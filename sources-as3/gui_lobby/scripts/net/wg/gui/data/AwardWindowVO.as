package net.wg.gui.data
{
   import net.wg.data.VO.AchievementItemVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AwardWindowVO extends DAAPIDataClass
   {
      
      private static const FIELD_ACHIEVEMENTS:String = "achievements";
      
      private static const AWARDS_BLOCK:String = "awardsBlock";
      
      private static const BACK_ANIMATION_DATA:String = "backAnimationData";
       
      
      public var backImage:String = "";
      
      public var awardImage:String = "";
      
      public var useBackAnimation:Boolean = false;
      
      public var backAnimationData:StoppableAnimationLoaderVO;
      
      public var windowTitle:String = "";
      
      public var header:String = "";
      
      public var description:String = "";
      
      public var additionalText:String = "";
      
      public var buttonText:String = "";
      
      public var isOKBtnEnabled:Boolean = true;
      
      public var isTakeNextBtnEnabled:Boolean = false;
      
      public var isCloseBtnEnabled:Boolean = false;
      
      public var isDashLineEnabled:Boolean = true;
      
      public var takeNextBtnLabel:String = "";
      
      public var closeBtnLabel:String = "";
      
      public var achievements:Array;
      
      public var textAreaIconPath:String = "";
      
      public var textAreaIconIsShow:Boolean = false;
      
      public var awardsBlock:TaskAwardsBlockVO = null;
      
      public var bodyBtnLinkage:String = "";
      
      public function AwardWindowVO(param1:Object)
      {
         this.achievements = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:AchievementItemVO = null;
         if(param1 == FIELD_ACHIEVEMENTS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            this.achievements = [];
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = Boolean(_loc4_) ? new AchievementItemVO(_loc4_) : null;
               this.achievements.push(_loc5_);
            }
            return false;
         }
         if(param1 == AWARDS_BLOCK)
         {
            this.awardsBlock = new TaskAwardsBlockVO(param2);
            return false;
         }
         if(param1 == BACK_ANIMATION_DATA && param2 != null)
         {
            this.backAnimationData = new StoppableAnimationLoaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.disposeAchievements();
         if(this.awardsBlock != null)
         {
            this.awardsBlock.dispose();
            this.awardsBlock = null;
         }
         if(this.backAnimationData != null)
         {
            this.backAnimationData.dispose();
            this.backAnimationData = null;
         }
         super.onDispose();
      }
      
      private function disposeAchievements() : void
      {
         var _loc1_:IDisposable = null;
         if(this.achievements.length > 0)
         {
            for each(_loc1_ in this.achievements)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
            }
            this.achievements.splice(0);
            this.achievements = null;
         }
      }
      
      public function get hasAchievements() : Boolean
      {
         return this.achievements && this.achievements.length > 0;
      }
   }
}
