package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class BottomPanelBillVO extends DAAPIDataClass
   {
      
      private static const LINES:String = "lines";
      
      private static const BUTTONS:String = "buttons";
       
      
      public var title:String = "";
      
      private var _lines:DataProvider;
      
      private var _buttons:DataProvider;
      
      public function BottomPanelBillVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(LINES == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,LINES + Errors.CANT_NULL);
            this._lines = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._lines.push(new CustomizationBillLineVO(_loc4_));
            }
            return false;
         }
         if(BUTTONS == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,LINES + Errors.CANT_NULL);
            this._buttons = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._buttons.push(new CustomizationBillButtonVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._lines)
         {
            this._lines.length = 0;
            this._lines = null;
         }
         if(this._buttons)
         {
            this._buttons.length = 0;
            this._buttons = null;
         }
         super.onDispose();
      }
      
      public function get lines() : DataProvider
      {
         return this._lines;
      }
      
      public function get buttons() : DataProvider
      {
         return this._buttons;
      }
   }
}
