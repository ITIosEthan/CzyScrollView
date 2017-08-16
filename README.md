 
 ####### 三张imageView实现多图循环滚动

```
        //设置默认图片
        centerImageView?.image = UIImage(named: self.imageNames[centerIndex])

        //三张图片 默认显示第一张
        scrollView?.contentOffset = CGPoint.init(x: kCzyFullWidth, y: 0)
```

```
        if currentOffsetX > kCzyFullWidth {
            
            centerIndex = (centerIndex + 1) % self.imageNames.count
            
        }else{
            
            centerIndex = (centerIndex+self.imageNames.count-1) % self.imageNames.count
        }
                
        //设置中间图片内容
        centerImageView?.image = UIImage(named: "\(centerIndex+1)")
        
        //总是偏移到中间图片
        scrollView.contentOffset = CGPoint.init(x: kCzyFullWidth, y: 0)
        
        //设置pageControl
        pageControl?.currentPage = centerIndex;
        
        //此时 滚动的时候会出现白边左边 是因为没有设置左右两张图片内容
        leftIndex = (centerIndex + self.imageNames.count - 1) % self.imageNames.count
        rightIndex = (centerIndex + 1) % self.imageNames.count
                
        leftImageView?.image = UIImage.init(named: "\(leftIndex)")
        rightImageView?.image = UIImage.init(named: "\(rightIndex)")
```
