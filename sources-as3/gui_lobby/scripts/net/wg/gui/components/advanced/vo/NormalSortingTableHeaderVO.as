package net.wg.gui.components.advanced.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import scaleform.clik.data.DataProvider;
   
   public class NormalSortingTableHeaderVO extends DAAPIDataClass
   {
      
      private static const HEADER:String = "tableHeader";
       
      
      private var _tableHeader:DataProvider = null;
      
      public function NormalSortingTableHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == HEADER)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"tableHeader " + Errors.CANT_NULL);
            this._tableHeader = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._tableHeader.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:NormalSortingBtnVO = null;
         for each(_loc1_ in this._tableHeader)
         {
            _loc1_.dispose();
         }
         this._tableHeader.splice(0,this._tableHeader.length);
         this._tableHeader = null;
         super.onDispose();
      }
      
      public function get tableHeader() : DataProvider
      {
         return this._tableHeader;
      }
   }
}
