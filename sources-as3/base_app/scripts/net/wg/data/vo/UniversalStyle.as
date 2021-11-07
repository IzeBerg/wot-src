package net.wg.data.vo
{
   import flash.filters.DropShadowFilter;
   import flash.utils.Dictionary;
   import net.wg.utils.IUniversalBtnStyledDisplayObjects;
   import net.wg.utils.IUniversalStyle;
   
   public class UniversalStyle implements IUniversalStyle
   {
      
      private static const POOL_MAX_LEN:int = 5;
       
      
      private var _statesLinkage:String = "";
      
      private var _disableBitmapSrc:String = "";
      
      private var _toggleIndicatorLinkage:String = "";
      
      private var _toggleGlowLinkage:String = "";
      
      private var _tfStateColors:Dictionary = null;
      
      private var _tfSize:uint = 13;
      
      private var _tfColor:uint = 16777215;
      
      private var _displayObjectsCash:Vector.<IUniversalBtnStyledDisplayObjects> = null;
      
      private var _shadowFilter:DropShadowFilter = null;
      
      public function UniversalStyle(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:uint, param7:Dictionary, param8:DropShadowFilter)
      {
         super();
         this._statesLinkage = param1;
         this._disableBitmapSrc = param2;
         this._toggleIndicatorLinkage = param3;
         this._toggleGlowLinkage = param4;
         this._tfSize = param5;
         this._tfColor = param6;
         this._tfStateColors = param7;
         this._displayObjectsCash = new Vector.<IUniversalBtnStyledDisplayObjects>();
         this._shadowFilter = param8;
      }
      
      public function addStyledDisplayObjects(param1:IUniversalBtnStyledDisplayObjects) : void
      {
         if(this._displayObjectsCash.length < POOL_MAX_LEN)
         {
            this._displayObjectsCash.push(param1);
         }
         else
         {
            param1.dispose();
            param1 = null;
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:IUniversalBtnStyledDisplayObjects = null;
         for(_loc1_ in this._tfStateColors)
         {
            delete this._tfStateColors[_loc1_];
         }
         this._tfStateColors = null;
         for each(_loc2_ in this._displayObjectsCash)
         {
            _loc2_.dispose();
         }
         this._displayObjectsCash.splice(0,this._displayObjectsCash.length);
         this._displayObjectsCash = null;
      }
      
      public function getStyledDisplayObjects() : IUniversalBtnStyledDisplayObjects
      {
         if(this._displayObjectsCash.length > 0)
         {
            return this._displayObjectsCash.pop();
         }
         return null;
      }
      
      public function get statesLinkage() : String
      {
         return this._statesLinkage;
      }
      
      public function get disableBitmapSrc() : String
      {
         return this._disableBitmapSrc;
      }
      
      public function get toggleIndicatorLinkage() : String
      {
         return this._toggleIndicatorLinkage;
      }
      
      public function get toggleGlowLinkage() : String
      {
         return this._toggleGlowLinkage;
      }
      
      public function get statesTextFieldColor() : Dictionary
      {
         return this._tfStateColors;
      }
      
      public function get tfSize() : uint
      {
         return this._tfSize;
      }
      
      public function get tfColor() : uint
      {
         return this._tfColor;
      }
      
      public function get tfShadowFilter() : DropShadowFilter
      {
         return this._shadowFilter;
      }
   }
}
