package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class BaseMissionDetailsContainerVO extends DAAPIDataClass
   {
      
      private static const PAGES:String = "pages";
       
      
      private var _pages:DataProvider;
      
      private var _len:int = 0;
      
      public function BaseMissionDetailsContainerVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._pages)
         {
            _loc1_.dispose();
         }
         this._pages.cleanUp();
         this._pages = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == PAGES)
         {
            this._pages = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._pages.push(new PaginatorPageNumVO(_loc3_));
            }
            this._len = this._pages.length;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get pages() : DataProvider
      {
         return this._pages;
      }
      
      public function get len() : int
      {
         return this._len;
      }
   }
}
