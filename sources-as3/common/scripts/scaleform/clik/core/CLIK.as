package scaleform.clik.core
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import scaleform.clik.managers.FocusHandler;
   import scaleform.clik.managers.PopUpManager;
   import scaleform.gfx.Extensions;
   
   public dynamic class CLIK
   {
      
      public static var stage:Stage;
      
      public static var initialized:Boolean = false;
      
      public static var disableNullFocusMoves:Boolean = false;
      
      public static var disableDynamicTextFieldFocus:Boolean = false;
      
      public static var disableTextFieldToNullFocusMoves:Boolean = true;
      
      public static var useImmediateCallbacks:Boolean = false;
      
      protected static var isInitListenerActive:Boolean = false;
      
      protected static var firingInitCallbacks:Boolean = false;
      
      protected static var initQueue:Dictionary;
      
      protected static var validDictIndices:Vector.<uint>;
       
      
      public function CLIK()
      {
         super();
      }
      
      public static function initialize(param1:Stage, param2:UIComponent) : void
      {
         if(initialized)
         {
            return;
         }
         CLIK.stage = param1;
         Extensions.enabled = true;
         initialized = true;
         FocusHandler.init(param1,param2);
         PopUpManager.init(param1);
         initQueue = new Dictionary(true);
         validDictIndices = new Vector.<uint>();
      }
      
      public static function getTargetPathFor(param1:DisplayObjectContainer) : String
      {
         var _loc2_:String = null;
         if(!param1.parent)
         {
            return param1.name;
         }
         _loc2_ = param1.name;
         return getTargetPathImpl(param1.parent as DisplayObjectContainer,_loc2_);
      }
      
      public static function queueInitCallback(param1:UIComponent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Dictionary = null;
         var _loc2_:String = getTargetPathFor(param1);
         if(useImmediateCallbacks || firingInitCallbacks)
         {
            Extensions.CLIK_addedToStageCallback(param1.name,_loc2_,param1);
         }
         else
         {
            _loc3_ = _loc2_.split(".");
            _loc4_ = _loc3_.length - 1;
            _loc5_ = initQueue[_loc4_];
            if(_loc5_ == null)
            {
               _loc5_ = new Dictionary(true);
               initQueue[_loc4_] = _loc5_;
               validDictIndices.push(_loc4_);
               if(validDictIndices.length > 1)
               {
                  validDictIndices.sort(sortFunc);
               }
            }
            _loc5_[param1] = _loc2_;
            if(!isInitListenerActive)
            {
               isInitListenerActive = true;
               stage.addEventListener(Event.EXIT_FRAME,fireInitCallback,false,0,true);
            }
         }
      }
      
      protected static function fireInitCallback(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Dictionary = null;
         var _loc5_:* = null;
         var _loc6_:UIComponent = null;
         firingInitCallbacks = true;
         stage.removeEventListener(Event.EXIT_FRAME,fireInitCallback,false);
         isInitListenerActive = false;
         while(_loc2_ < validDictIndices.length)
         {
            _loc3_ = validDictIndices[_loc2_];
            _loc4_ = initQueue[_loc3_] as Dictionary;
            for(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_ as UIComponent;
               Extensions.CLIK_addedToStageCallback(_loc6_.name,_loc4_[_loc6_],_loc6_);
               _loc4_[_loc6_] = null;
            }
            _loc2_++;
         }
         validDictIndices.length = 0;
         clearQueue();
         firingInitCallbacks = false;
      }
      
      protected static function clearQueue() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in initQueue)
         {
            initQueue[_loc1_] = null;
         }
      }
      
      protected static function sortFunc(param1:uint, param2:uint) : Number
      {
         if(param1 < param2)
         {
            return -1;
         }
         if(param1 > param2)
         {
            return 1;
         }
         return 0;
      }
      
      protected static function getTargetPathImpl(param1:DisplayObjectContainer, param2:String = "") : String
      {
         var _loc3_:String = null;
         if(!param1)
         {
            return param2;
         }
         _loc3_ = Boolean(param1.name) ? param1.name + "." : "";
         param2 = _loc3_ + param2;
         return getTargetPathImpl(param1.parent as DisplayObjectContainer,param2);
      }
   }
}
