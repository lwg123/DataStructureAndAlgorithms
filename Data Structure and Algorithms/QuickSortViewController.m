//
//  QuickSortViewController.m
//  Data Structure and Algorithms
//
//  Created by weiguang on 2019/5/22.
//  Copyright © 2019 duia. All rights reserved.
//

#import "QuickSortViewController.h"

@interface QuickSortViewController ()

@end

@implementation QuickSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   NSMutableArray *array = @[@31,@4,@11,@16,@5,@2,@9,@7,@20].mutableCopy;
   NSArray *resultArr = [self quickSortArray:array left:0 right:array.count-1];
    
    NSLog(@"array:---%@",resultArr);
    
    NSArray *arr = @[@1,@3,@4,@6,@7,@8,@9];
    NSArray *arr0 = @[@2,@3,@5,@7,@8,@9];
    NSArray *arr1 = @[@2,@3,@7,@7,@8,@9];
    
    NSInteger i = [self searchTarget:7 fromArr:arr];
    NSInteger j = [self searchTarget:7 fromArr:arr0];
    NSInteger k = [self searchTarget:7 fromArr:arr1];
    NSLog(@"i = %ld\n j = %ld \n k = %ld",i,j,k);
    
}

/*
 *
 1 设置两个变量i，j  ，排序开始时i = 0，就j = mutableArray.count - 1；
 2 设置数组的第一个值为比较基准数key，key = mutableArray.count[0]；
 3因为设置key为数组的第一个值，所以先从数组最右边开始往前查找比key小的值。如果没有找到，j--继续往前搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往前搜索，进入第4步；
 4.从i位置开始往后搜索比可以大的值，如果没有找到，i++继续往后搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往后搜索；
 5.重复第3、4步，直到i == j（此时刚好执行完第三步或第四部），停止排序；
 
 */
- (NSArray *)quickSortArray:(NSMutableArray *)arr
                  left:(NSInteger)left
                 right:(NSInteger)right
{
    if (left >= right) { //如果数组长度为0或1时返回  递归调用的必备跳出
        return arr;
    }
    
    NSInteger i,j,base;
    i = left;
    j = right;
    base = [arr[i] integerValue];
    while (i < j) {
        while (i < j && [arr[j] integerValue] >= base) {//如果比基准数大，继续查找
            j--;
        }
        // 如果比基准数小，则将查找到的小值调换到i的位置
        arr[i] = arr[j];
        
        /* 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 */
        while (i < j && [arr[i] integerValue] <= base) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        arr[j] = arr[i];
    }
    
    //将基准数放到正确位置
    arr[i] = @(base);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:arr left:left right:i-1];
    //排序基准数右边的
    [self quickSortArray:arr left:i+1 right:right];
    
    return arr;
}


/**
 二分查找,默认查找有序数组
 */
- (NSInteger)searchTarget:(NSInteger)target fromArr:(NSArray *)arr
{
    if (arr.count < 1) {
        return -1;
    }
    NSInteger start,mid,end;
    start = 0;
    mid = 0;
    end = arr.count - 1;
    //就剩两个数的时候 start = end - 1;这个条件跳出
    while (start < end - 1) {
        mid = start + (end - start)/2;
        if ([arr[mid] integerValue] > target) {
            end = mid;
        }else {
            start = mid;
        }
    }
    
    if (target == [arr[start] integerValue]) {
        return start;
    }
    
    if (target == [arr[end] integerValue]) {
        return end;
    }
    
    return -1;
}



@end
