package net.wg.data
{
   import net.wg.data.constants.TweenTypes;
   import net.wg.infrastructure.interfaces.ITweenTypesDuration;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   
   public class TweenDataByType implements ITweenTypesDuration
   {
      
      private static var propertiesByType:Object = null;
      
      public static const TYPE_ADD:String = "add";
      
      public static const TYPE_SET:String = "set";
       
      
      private var _types:Vector.<String> = null;
      
      private var _duration:int;
      
      public function TweenDataByType(param1:Vector.<String>, param2:int)
      {
         super();
         if(propertiesByType == null)
         {
            customizeData();
         }
         this.types = Vector.<String>(param1);
         this.duration = param2;
      }
      
      public static function getPropertyChanges(param1:String) : Object
      {
         return propertiesByType[param1];
      }
      
      private static function customizeData() : void
      {
         var _loc1_:ITweenManagerHelper = App.tweenMgr.getTweenManagerHelper();
         propertiesByType = {};
         propertiesByType[TweenTypes.FADE_IN] = {
            "type":TYPE_SET,
            "propertyName":"alpha",
            "value":_loc1_.getFadeAlphaMax()
         };
         propertiesByType[TweenTypes.FADE_OUT] = {
            "type":TYPE_SET,
            "propertyName":"alpha",
            "value":_loc1_.getFadeAlphaMin()
         };
         propertiesByType[TweenTypes.MOVE_UP] = {
            "type":TYPE_ADD,
            "propertyName":"y",
            "value":_loc1_.getTranslationLength()
         };
         propertiesByType[TweenTypes.MOVE_DOWN] = {
            "type":TYPE_ADD,
            "propertyName":"y",
            "value":_loc1_.getTranslationLength()
         };
         propertiesByType[TweenTypes.TURN_HALF] = {
            "type":TYPE_ADD,
            "propertyName":"rotation",
            "value":180
         };
      }
      
      public function get types() : Vector.<String>
      {
         return this._types;
      }
      
      public function set types(param1:Vector.<String>) : void
      {
         this._types = param1;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
      
      public function set duration(param1:int) : void
      {
         this._duration = param1;
      }
      
      private function get tweenMgrHelper() : ITweenManagerHelper
      {
         return App.tweenMgr.getTweenManagerHelper();
      }
   }
}
