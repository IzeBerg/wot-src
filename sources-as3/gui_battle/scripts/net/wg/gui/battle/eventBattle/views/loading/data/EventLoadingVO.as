package net.wg.gui.battle.eventBattle.views.loading.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventLoadingVO extends DAAPIDataClass
   {
      
      private static const LESSON_PAGES_BIG_DATA:String = "lessonPagesBigData";
      
      private static const LESSON_PAGES_SMALL_DATA:String = "lessonPagesSmallData";
       
      
      public var navigationButtonsVisible:Boolean = false;
      
      public var lessonPagesBigData:Vector.<EventLoadingPageVO>;
      
      public var lessonPagesSmallData:Vector.<EventLoadingPageVO>;
      
      public function EventLoadingVO(param1:Object)
      {
         this.lessonPagesBigData = new Vector.<EventLoadingPageVO>();
         this.lessonPagesSmallData = new Vector.<EventLoadingPageVO>();
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
               this.lessonPagesBigData.push(new EventLoadingPageVO(_loc4_));
            }
            return false;
         }
         if(param1 == LESSON_PAGES_SMALL_DATA)
         {
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.lessonPagesSmallData.push(new EventLoadingPageVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EventLoadingPageVO = null;
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
         super.onDispose();
      }
   }
}
