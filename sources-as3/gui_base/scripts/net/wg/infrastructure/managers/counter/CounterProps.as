package net.wg.infrastructure.managers.counter
{
   import net.wg.data.constants.Linkages;
   import net.wg.utils.ICounterProps;
   
   public class CounterProps implements ICounterProps
   {
      
      public static const DEFAULT_LINKAGE:String = Linkages.COUNTER_UI;
      
      public static const DEFAULT_OFFSET_X:Number = 2;
      
      public static const DEFAULT_OFFSET_Y:Number = 2;
      
      public static const DEFAULT_TF_PADDING:Number = 15;
      
      public static const DEFAULT_PROPS:CounterProps = new CounterProps();
       
      
      private var _offsetX:Number = 0;
      
      private var _offsetY:Number = 0;
      
      private var _addToTop:Boolean = true;
      
      private var _linkage:String = null;
      
      private var _horizontalAlign:String = null;
      
      private var _tfPadding:Number = 0;
      
      private var _checkEmptyValue:Boolean = true;
      
      private var _viewState:String = null;
      
      public function CounterProps(param1:Number = 2, param2:Number = 2, param3:String = "left", param4:Boolean = true, param5:String = "CounterUI", param6:Number = 15, param7:Boolean = true, param8:String = null)
      {
         super();
         this._offsetX = param1;
         this._offsetY = param2;
         this._addToTop = param4;
         this._linkage = param5;
         this._tfPadding = param6;
         this._horizontalAlign = param3;
         this._checkEmptyValue = param7;
         this._viewState = param8;
      }
      
      public function get offsetX() : int
      {
         return this._offsetX;
      }
      
      public function get offsetY() : int
      {
         return this._offsetY;
      }
      
      public function get tfPadding() : int
      {
         return this._tfPadding;
      }
      
      public function get addToTop() : Boolean
      {
         return this._addToTop;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      public function get checkEmptyValue() : Boolean
      {
         return this._checkEmptyValue;
      }
      
      public function get viewState() : String
      {
         return this._viewState;
      }
   }
}
