package net.wg.gui.lobby.manualChapter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ManualChapterContainerVO extends DAAPIDataClass
   {
      
      private static const PAGES:String = "pages";
      
      private static const DETAILS:String = "details";
       
      
      public var title:String = "";
      
      private var _details:Vector.<ManualPageDetailedViewVO>;
      
      private var _pages:DataProvider;
      
      public function ManualChapterContainerVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:IDisposable = null;
         for each(_loc1_ in this._details)
         {
            _loc1_.dispose();
         }
         this._details.splice(0,this._details.length);
         this._details = null;
         for each(_loc2_ in this._pages)
         {
            _loc2_.dispose();
         }
         this._pages.cleanUp();
         this._pages = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(param1 == DETAILS)
         {
            this._details = new Vector.<ManualPageDetailedViewVO>();
            for each(_loc3_ in param2)
            {
               this._details.push(new ManualPageDetailedViewVO(_loc3_));
            }
            return false;
         }
         if(param1 == PAGES)
         {
            this._pages = new DataProvider();
            for each(_loc4_ in param2)
            {
               this._pages.push(new PaginatorPageNumVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get details() : Vector.<ManualPageDetailedViewVO>
      {
         return this._details;
      }
      
      public function get pages() : DataProvider
      {
         return this._pages;
      }
   }
}
