package net.wg.data.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class TrainingRoomTeamVO extends TrainingRoomTeamBaseVO
   {
      
      public static const LIST_DATA_FIELD:String = "listData";
       
      
      public var listData:DataProvider = null;
      
      public function TrainingRoomTeamVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == LIST_DATA_FIELD)
         {
            this.listData = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assert(_loc3_ != null,LIST_DATA_FIELD + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.listData[_loc5_] = new TrainingRoomRendererVO(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.listData != null)
         {
            for each(_loc1_ in this.listData)
            {
               _loc1_.dispose();
            }
            this.listData.cleanUp();
            this.listData = null;
         }
         super.onDispose();
      }
   }
}
