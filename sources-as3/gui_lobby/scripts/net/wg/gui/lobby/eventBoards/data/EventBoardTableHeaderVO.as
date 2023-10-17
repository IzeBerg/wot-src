package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventBoardTableHeaderVO extends DAAPIDataClass
   {
      
      private static const COLUMNS:String = "columns";
       
      
      public var columns:Vector.<EventBoardTableHeaderIconVO> = null;
      
      public var dateTooltip:String = "";
      
      public var technicsTooltip:String = "";
      
      public var resultTooltip:String = "";
      
      public var positionTooltip:String = "";
      
      public var playerTooltip:String = "";
      
      public function EventBoardTableHeaderVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:EventBoardTableHeaderIconVO = null;
         var _loc5_:Object = null;
         if(param1 == COLUMNS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"icons" + Errors.CANT_NULL);
            this.columns = new Vector.<EventBoardTableHeaderIconVO>();
            _loc4_ = null;
            for each(_loc5_ in _loc3_)
            {
               _loc4_ = new EventBoardTableHeaderIconVO(_loc5_);
               this.columns.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.columns)
         {
            _loc1_.dispose();
         }
         this.columns.splice(0,this.columns.length);
         this.columns = null;
         super.onDispose();
      }
   }
}
