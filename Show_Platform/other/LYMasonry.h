//
//  LYMasonry.h
//  AAAA
//
//  Created by liang on 16/6/13.
//  Copyright © 2016年 梁银龙. All rights reserved.
//



/********************************************************************************/

//添加之后就不用用带 msa_开头的方法了
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


//------------------------
#ifndef LYMasonry_h
#define LYMasonry_h

#import "Masonry.h"


#endif /* LYMasonry_h */
//-------------------------


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;



//--Masonry 封装

#define makeTop(t) make.top.equalTo(t)//顶部
#define makeLeft(l) make.left.equalTo(l)//左边
#define makeRight(r) make.right.equalTo(r)//右边
#define makeBottom(b) make.bottom.equalTo(b)//底部

#define makeWidth(w) make.width.equalTo(w)//宽
#define makeHeight(h) make.height.equalTo(h)//高

#define makeSize(w,h) make.size.equalTo(CGSizeMake(w, h))//size
#define makeSizeView(view) make.size.equalTo(view)//和那个 View.size 相同

#define makeCenter(x,y) make.center.equalTo(CGSizeMake(x, y))//中心
#define makeCenterView(view) make.center.equalTo(view)//以那个 view 为中心点

//边到外边的距离.(不允许空值,一般不为负数)
#define makeEdges(t,l,b,r) make.edges.equalTo(UIEdgeInsetsMake(t, l, b, r));
//边到外边的位置,上左下右. (允许空值)[为 nil, 跳过设置]
#define makeMargin(t,l,b,r)  if(t){makeTop(t);}if(l){makeLeft(l);}if(b){makeBottom(b);}if(r){makeRight(r);}




/********************************************************************************/
















