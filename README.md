# ArcTransformer
用来把MRC转成ARC的工具工程
主要使用正则表达式去替换一些常用的工作
PS：1.先设置工程的automaticReferenceCount 改为YES，并把对应需要仍以MRC处理的项目打上TAG
  2.使用工具去转换
  3.使用的过程如果发现了一些不好改成ARC的类，把这个类的文件名(h&&m)放进plist里面，为自动忽略
  4.一些后续的问题：
      I.有的开发者喜欢在MRC里面创建一个View，self.view addSubview:xx,然后直接释放，而当前VC对这个View的引用是assign的，此时改成weak后，这种实现会导致view在传值的一瞬间马上被释放，这个需要自己去改（analyse的warning也会显性地指出这一点的）
