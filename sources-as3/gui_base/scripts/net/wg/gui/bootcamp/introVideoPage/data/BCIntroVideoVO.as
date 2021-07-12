package net.wg.gui.bootcamp.introVideoPage.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import scaleform.clik.data.DataProvider;
   
   public class BCIntroVideoVO extends DAAPIDataClass
   {
      
      private static const REWARDS:String = "rewards";
      
      private static const LESSON_PAGES_BIG_DATA:String = "lessonPagesBigData";
      
      private static const LESSON_PAGES_SMALL_DATA:String = "lessonPagesSmallData";
       
      
      public var isReferralEnabled:Boolean = false;
      
      public var isBootcampCloseEnabled:Boolean = false;
      
      public var referralDescription:String = "";
      
      public var showTutorialPages:Boolean = false;
      
      public var backgroundVideo:String = "";
      
      public var source:String = "";
      
      public var autoStart:Boolean = false;
      
      public var navigationButtonsVisible:Boolean = false;
      
      public var videoPlayerVisible:Boolean = false;
      
      public var allowSkipButton:Boolean = false;
      
      public var selectButtonLabel:String = "";
      
      public var bufferTime:Number = 0;
      
      public var lessonPagesBigData:Vector.<BCTutorialPageVO>;
      
      public var lessonPagesSmallData:Vector.<BCTutorialPageVO>;
      
      public var rewards:DataProvider = null;
      
      public function BCIntroVideoVO(param1:Object)
      {
         this.lessonPagesBigData = new Vector.<BCTutorialPageVO>();
         this.lessonPagesSmallData = new Vector.<BCTutorialPageVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == LESSON_PAGES_BIG_DATA)
         {
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.lessonPagesBigData.push(new BCTutorialPageVO(_loc4_));
            }
            return false;
         }
         if(param1 == LESSON_PAGES_SMALL_DATA)
         {
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.lessonPagesSmallData.push(new BCTutorialPageVO(_loc4_));
            }
            return false;
         }
         if(param1 == REWARDS)
         {
            this.rewards = new DataProvider();
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.rewards.push(new RewardRendererVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BCTutorialPageVO = null;
         var _loc2_:RewardRendererVO = null;
         for each(_loc1_ in this.lessonPagesBigData)
         {
            _loc1_.dispose();
         }
         this.lessonPagesBigData.splice(0,this.lessonPagesBigData.length);
         this.lessonPagesBigData = null;
         for each(_loc1_ in this.lessonPagesSmallData)
         {
            _loc1_.dispose();
         }
         this.lessonPagesSmallData.splice(0,this.lessonPagesSmallData.length);
         this.lessonPagesSmallData = null;
         this.selectButtonLabel = null;
         if(this.rewards)
         {
            for each(_loc2_ in this.rewards)
            {
               _loc2_.dispose();
            }
            this.rewards.cleanUp();
            this.rewards = null;
         }
         super.onDispose();
      }
   }
}
