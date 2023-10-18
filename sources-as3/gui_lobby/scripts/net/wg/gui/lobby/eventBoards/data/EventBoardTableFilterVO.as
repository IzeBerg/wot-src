package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class EventBoardTableFilterVO extends DAAPIDataClass
   {
      
      private static const FILTERS:String = "filters";
       
      
      public var tooltip:String = "";
      
      private var _selected:int = -1;
      
      private var _filters:DataProvider = null;
      
      public function EventBoardTableFilterVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:SimpleRendererVO = null;
         if(param1 == FILTERS)
         {
            this._filters = new DataProvider();
            for each(_loc3_ in param2)
            {
               _loc4_ = new SimpleRendererVO(_loc3_);
               this._filters.push(_loc4_);
               if(_loc4_.selected)
               {
                  this._selected = this._filters.length - 1;
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._filters)
         {
            _loc1_.dispose();
         }
         if(this._filters)
         {
            this._filters.cleanUp();
         }
         this._filters = null;
         super.onDispose();
      }
      
      public function get filters() : DataProvider
      {
         return this._filters;
      }
      
      public function get selected() : int
      {
         return this._selected;
      }
   }
}
