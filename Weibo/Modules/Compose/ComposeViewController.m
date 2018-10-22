//
//  ComposeViewController.m
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "ComposeViewController.h"
#import "JRTextView.h"
#import "ComposeToolbar.h"
#import "PhotosView.h"
#import "AccountTool.h"
#import "Account.h"

@interface ComposeViewController () <ComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) JRTextView *textView;
@property (nonatomic, weak) ComposeToolbar *toolbar;
@property (nonatomic, weak) PhotosView *photosView;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setupNavBar];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加显示图片的相册控件
    [self setupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

#pragma mark - 设置导航栏内容

- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 设置输入框

- (void)setupTextView
{
    // 1.创建输入控件
    JRTextView *textView = [[JRTextView alloc] init];
//    textView.frame = self.view.bounds;
    textView.x = 10;
    textView.y = 5;
    textView.height = self.view.height;
    textView.width = self.view.width - 2 * textView.x;
    
    textView.alwaysBounceVertical = YES; // 添加垂直方向永远有滚动效果
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置占位文字
    textView.placeholder = @"分享新鲜事...";
    
    // 3.监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 移除通知：不然再出进入控制器再次创建会导致通知重复
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置键盘上的工具条

- (void)setupToolbar
{
    // 1.创建
    ComposeToolbar *toolbar = [[ComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    
    // 2.显示
//    self.textView.inputAccessoryView = toolbar;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

#pragma mark - 添加显示图片的相册控件

- (void)setupPhotosView
{
    PhotosView *photosView = [[PhotosView alloc] init];
    photosView.x = 5;
    photosView.y = 70;
    photosView.width = self.textView.width - 2 * photosView.x;
    photosView.height = self.textView.height;
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

#pragma mark - 键盘弹出隐藏处理

- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UITextViewDelegate

// 用户开始拖拽scrollview时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

// 设置当textView的文字长度不为0时可以点击
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - ComposeToolbar Delegate

- (void)composeTool:(ComposeToolbar *)toolbar didClickedButton:(ComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case ComposeToolbarButtonTypeCamera: // 照相机
            NSLog(@"打开照相机");
            [self openCameral];
            break;
            
        case ComposeToolbarButtonTypePicture: // 相册
            NSLog(@"打开相册");
            [self openAlbum];
            break;
            
        case ComposeToolbarButtonTypeMention: // 提到@
            NSLog(@"打开提到@");
            break;
            
        case ComposeToolbarButtonTypeTrend: // 话题
            NSLog(@"打开话题");
            break;
            
        case ComposeToolbarButtonTypeEmotion: // 表情
            NSLog(@"打开表情");
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

#pragma mark - 工具栏的打开方法

// 打开相机
- (void)openCameral
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
//    ipc.allowsEditing = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

// 打开相册
- (void)openAlbum
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType =UIImagePickerControllerSourceTypePhotoLibrary; // 默认的属性
    ipc.delegate = self;
//    ipc.allowsEditing = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

// 打开表情
- (void)openEmotion
{
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}

#pragma mark - 导航栏左右按钮点击方法

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    // 1.发表微博
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil]; 
}

- (void)sendStatusWithImage
{
//    // 1.获取请求管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //  解决返回类型不兼容的问题(网络传输协议)
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [AccountTool account].access_token;
//    params[@"status"] = self.textView.text;
//
//    // 3.发送POST请求
//    [manager POST:URL_Upload parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        UIImage *image = [self.photosView.images firstObject];
//
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//
//        // 拼接文件参数
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
//
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *statusDict) {
//        [MBProgressHUD showSuccess:@"发表成功"];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showError:@"发表失败"];
//    }];
}

- (void)sendStatusWithoutImage
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 2.发送POST请求
    [HttpTool post:URL_Update params:params success:^(id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}

@end
