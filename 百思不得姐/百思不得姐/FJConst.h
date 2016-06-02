#import <Foundation/Foundation.h>

/**
 精华的分类
 */
typedef enum {
    FJTopicTypeAll = 1,
    FJTopicTypePicture = 10,
    FJTopicTypeWord = 29,
    FJTopicTypeVoice = 31,
    FJTopicTypeVideo = 41
} FJTopicType;

/**
 *  精华顶部标题的高度
 */
UIKIT_EXTERN CGFloat const FJTitlesViewH;
/**
 *  精华顶部标题的Y
 */
UIKIT_EXTERN CGFloat const FJTitlesViewY;
/**
 *  精华cell间距
 */
UIKIT_EXTERN CGFloat const FJTopicCellMargin;
/**
 *  精华cell文字内容的Y
 */
UIKIT_EXTERN CGFloat const FJTopicCellTextY;
/**
 *  精华cell底部工具栏的高度
 */
UIKIT_EXTERN CGFloat const FJTopicCellBottomBarH;
/**
 *  精华cell图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const FJTopicCellPictureMaxH;
/**
 *  精华cell图片帖子为长图是显示一部分的高度
 */
UIKIT_EXTERN CGFloat const FJTopicCellPictureBreakH;
/**
 *  FJUser模型 -> 性别
 */
UIKIT_EXTERN NSString * const FJUserSexMale;
UIKIT_EXTERN NSString * const FJUserSexFemale;
/**
 *  最热评论标题高度
 */
UIKIT_EXTERN CGFloat const FJTopicCellTopCmtTitleH;
/**
 *  tabBar被选中的通知名字
 */
UIKIT_EXTERN NSString * const FJTabBarDidSelectNotification;
/**
 *  tabBar被选中的通知 - 控制器index key
 */
UIKIT_EXTERN NSString * const FJSelectedControllerIndexKey;
/**
 *  tabBar被点击的通知名字 - 控制器key
 */
UIKIT_EXTERN NSString * const FJSelectedControllerKey;