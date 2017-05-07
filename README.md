#导语
最近笔者总是有一颗骚动的心不停地跳跃着，那就是想独立开发一款小型的网游。独立开发网游，简直是我的天！对于个人来说实在太难了，不光要客户端这边搞定，还得把后端服务器这边也得搞定。虽然难，但还是想一试，梦想总要有的，万一实现了呢:-）
首先技术选型，因为笔者对ios的Scene Kit更熟，恰巧ios 8又已出来多年，所以客户端这边我只考虑iOS的话已完全够啦。那服务器端呢，我也是看了一些引擎，最后看下来还是网易的Pomelo框架比较适合我，这款引擎不但完全开源，甚至还有比较不错的线上demo，除了这些nodejs也是我选择的原因，轻量便捷，语法简洁，相信我能学的比较快。

#测试我想要的demo
1.[iOS客户端测试demo](https://github.com/NetEase/pomelo-ioschat)
2.[服务端demo](https://github.com/NetEase/chatofpomelo)

#遇到问题
1.可能这个iOS demo年代久远的原因，我一运行就挂了，当然毕竟我是专业的ios人员，所以修改了一下，这个ios demo可以跑出来了。修改内容主要如下：
![修改内容](http://upload-images.jianshu.io/upload_images/2197489-ed544759a60d6e24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.根据[chat源码下载与安装指南](https://github.com/NetEase/pomelo/wiki/chat源码下载与安装)，我成功地在本地运行起Game Server。但是当我试图用模拟器登录时，又一次出现了，问题，登录不了，并出现如下错误：
![错误](http://upload-images.jianshu.io/upload_images/2197489-9f29ded62eb89110.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在网上查找了一下原因，说是客户端和服务器端socket.io库版本不匹配的原因。查看一下当前Game Server使用的socket.io库版本：
![1](http://upload-images.jianshu.io/upload_images/2197489-8059128392321d56.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![2](http://upload-images.jianshu.io/upload_images/2197489-cd555e23dd15735b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
当前使用的pomelo2.2.5的库里使用的socket.io 1.0以上的版本，正是因为1.0以上和客户端这边的socket.io不匹配才出现了这个问题。那么有两种方案，一种是升级ios客户端这边socketio库，还有一种是降低pomelo使用的socketio版本。前者笔者尝试了，但没有得到解决，出于能力有限的原因，如果有能解决的朋友希望能指导下我们。这边我只摸索出了第二种解决方法，我查看了一下pomelo的上一个版本：
![1](http://upload-images.jianshu.io/upload_images/2197489-ed6cb5d40d22947e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
它使用的正是是我们想要的socket.io库1.0以下版本。解决方案如下：
![1](http://upload-images.jianshu.io/upload_images/2197489-6907be7071e180fd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

再次测试后，我们的ios客户端确实可以和服务器通信了，感兴趣的读者可以尝试用自己的iphone手机和ios模拟器进行通讯。
以下是模拟器和我真机通过pomelo服务器模拟的同一个频道的聊天。
![demo.gif](http://upload-images.jianshu.io/upload_images/2197489-f61dd60e8c2ac20f.gif?imageMogr2/auto-orient/strip)
