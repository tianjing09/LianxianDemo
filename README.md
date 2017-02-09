# LianxianDemo
将两组要连线的frame传到lianxianview的frameArray里，就可以进行连线
主要思想是在你自定义的view上添加覆盖层，即LianxianView.LianxianView主要是在根据所传的俩组frame进行画线，判断是否连接正确。
```
LianxianView *view = [[LianxianView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
view.delegate = self;
view.frameArray = frameArray;
[self.view addSubview:view];

```