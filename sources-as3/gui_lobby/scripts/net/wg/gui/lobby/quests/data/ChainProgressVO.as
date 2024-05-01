package net.wg.gui.lobby.quests.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ChainProgressVO extends DAAPIDataClass
   {
      
      private static const PROGRESS_ITEMS:String = "progressItems";
       
      
      public var progressItems:Vector.<ChainProgressItemVO>;
      
      public function ChainProgressVO(param1:Object)
      {
         this.progressItems = new Vector.<ChainProgressItemVO>(0);
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == PROGRESS_ITEMS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.progressItems.push(new ChainProgressItemVO(_loc3_[_loc5_]));
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:uint = this.progressItems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.progressItems[_loc2_].dispose();
            _loc2_++;
         }
         this.progressItems.splice(0,_loc1_);
         this.progressItems = null;
         super.onDispose();
      }
   }
}
