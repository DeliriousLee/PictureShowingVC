# PictureShowingVC
iOS OC a ViewController to Show Picture,Use ScrollView. Can Zoom in &amp; Zoom out.  

![Image text](https://github.com/DeliriousLee/PictureShowingVC/blob/master/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-08-27%20%E4%B8%8B%E5%8D%883.49.08%201.png)
>用法:直接拖进项目里面

<code>UIImage *showImage=[[UIImage alloc]init];//替换为自己的图片</code>

<code>HZSFPictureToolViewController *vc=[[HZSFPictureToolViewController alloc]initWithShowImage:showImage];</code>

<code>[self.navigationController pushViewController:vc animated:YES];</code>
>
    组件设置标题的方式有问题，可以自己修改
