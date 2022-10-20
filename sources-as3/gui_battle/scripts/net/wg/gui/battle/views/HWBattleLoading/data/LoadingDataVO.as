package net.wg.gui.battle.views.HWBattleLoading.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class LoadingDataVO extends DAAPIDataClass
   {
      
      private static const PAGES:String = "pages";
       
      
      public var currentPageIndex:int = -1;
      
      public var pages:Vector.<BattleLoadingHintVO>;
      
      public function LoadingDataVO(param1:Object)
      {
         this.pages = new Vector.<BattleLoadingHintVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == PAGES)
         {
            _loc3_ = param2 as Array;
            for each(_loc4_ in _loc3_)
            {
               this.pages.push(new BattleLoadingHintVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleLoadingHintVO = null;
         for each(_loc1_ in this.pages)
         {
            _loc1_.dispose();
         }
         this.pages.splice(0,this.pages.length);
         this.pages = null;
         super.onDispose();
      }
   }
}
