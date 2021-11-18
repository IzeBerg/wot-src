package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   
   public class UnitListViewHeaderVO extends DAAPIDataClass
   {
      
      private static const COLUMN_HEADERS:String = "columnHeaders";
       
      
      public var title:String = "";
      
      public var createBtnLabel:String = "";
      
      public var createBtnTooltip:String = "";
      
      public var createBtnEnabled:Boolean = true;
      
      private var _header:Vector.<NormalSortingBtnVO> = null;
      
      public function UnitListViewHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == COLUMN_HEADERS)
         {
            _loc3_ = param2 as Array;
            this._header = new Vector.<NormalSortingBtnVO>(0);
            for each(_loc4_ in _loc3_)
            {
               this._header.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:NormalSortingBtnVO = null;
         for each(_loc1_ in this._header)
         {
            _loc1_.dispose();
         }
         this._header.splice(0,this._header.length);
         this._header = null;
         super.onDispose();
      }
      
      public function get header() : Vector.<NormalSortingBtnVO>
      {
         return this._header;
      }
   }
}
