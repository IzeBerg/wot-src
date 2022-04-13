package net.wg.gui.battle.commander.views.common
{
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class Clips extends BattleUIComponent
   {
      
      public static const CLIPS_BULLET_TYPE:String = "BULLET";
      
      public static const CLIPS_RECT_TYPE:String = "RECT";
      
      public static const CLIPS_LEFT_DIRECTION:String = "left";
      
      public static const CLIPS_RIGHT_DIRECTION:String = "right";
      
      private static const ITEM_RENDERER_BULLET:String = "ClipsBulletUI";
      
      private static const ITEM_RENDERER_RECT:String = "ClipsRectUI";
      
      private static const COLOR_BLACK:String = "black";
      
      private static const COLOR_RED:String = "red";
      
      private static const COLOR_YELLOW:String = "yellow";
      
      private static const COLOR_GREEN:String = "green";
      
      private static const INVALID_MAX_COUNT:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_CLIPS_TYPE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALID_CLIPS_DIRECTION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const CLIPS_TYPES:Object = {
         "BULLET":{
            "renderer":ITEM_RENDERER_BULLET,
            "width":4 + 1
         },
         "RECT":{
            "renderer":ITEM_RENDERER_RECT,
            "width":3 + 1
         }
      };
       
      
      public var container:MovieClip = null;
      
      private var _items:Vector.<MovieClip>;
      
      private var _currentCount:int;
      
      private var _maxCount:int;
      
      private var _isDualgun:Boolean;
      
      private var _isAutoload:Boolean;
      
      private var _isAlive:Boolean;
      
      private var _currentClipsType:String = "BULLET";
      
      private var _currentClipsDirection:String = "right";
      
      public function Clips()
      {
         this._items = new Vector.<MovieClip>();
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(isInvalid(INVALID_MAX_COUNT) || isInvalid(INVALID_CLIPS_TYPE) || isInvalid(INVALID_CLIPS_DIRECTION))
         {
            this.removeAll();
            if(this._maxCount > 1)
            {
               _loc1_ = 0;
               while(_loc1_ < this._maxCount)
               {
                  this.addItem(_loc1_);
                  _loc1_++;
               }
               if(this._currentClipsDirection == CLIPS_LEFT_DIRECTION)
               {
                  this.container.x -= this.container.width;
               }
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._maxCount > 1)
            {
               this.setColor(0,this.usedCount,COLOR_BLACK);
               if(this._currentCount == 1)
               {
                  _loc2_ = COLOR_RED;
               }
               else if(!this.isDualgun && !this.isAutoload && this._maxCount > 4 && this._currentCount == 2)
               {
                  _loc2_ = COLOR_YELLOW;
               }
               else
               {
                  _loc2_ = COLOR_GREEN;
               }
               this.setColor(this.usedCount,this._maxCount,_loc2_);
            }
            visible = this.isAlive;
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeAll();
         this.container = null;
         super.onDispose();
      }
      
      private function removeAll() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._items)
         {
            this.container.removeChild(_loc1_);
         }
         this._items.length = 0;
      }
      
      private function addItem(param1:int) : void
      {
         var _loc2_:Object = CLIPS_TYPES[this._currentClipsType];
         var _loc3_:Class = getDefinitionByName(_loc2_.renderer) as Class;
         var _loc4_:MovieClip = new _loc3_();
         _loc4_.x = param1 * _loc2_.width;
         _loc4_.gotoAndStop(COLOR_BLACK);
         this.container.addChild(_loc4_);
         this._items.push(_loc4_);
      }
      
      private function setColor(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:int = param1;
         while(_loc4_ < param2)
         {
            this._items[_loc4_].gotoAndStop(param3);
            _loc4_++;
         }
      }
      
      public function get usedCount() : int
      {
         return this._maxCount - this._currentCount;
      }
      
      public function get maxCount() : int
      {
         return this._maxCount;
      }
      
      public function set maxCount(param1:int) : void
      {
         if(this._maxCount != param1)
         {
            this._maxCount = param1;
            invalidate(INVALID_MAX_COUNT);
         }
      }
      
      public function get currentCount() : int
      {
         return this._currentCount;
      }
      
      public function set currentCount(param1:int) : void
      {
         if(this._currentCount != param1)
         {
            this._currentCount = param1;
            invalidateData();
         }
      }
      
      public function get isDualgun() : Boolean
      {
         return this._isDualgun;
      }
      
      public function set isDualgun(param1:Boolean) : void
      {
         if(this._isDualgun != param1)
         {
            this._isDualgun = param1;
            invalidateData();
         }
      }
      
      public function get isAutoload() : Boolean
      {
         return this._isAutoload;
      }
      
      public function set isAutoload(param1:Boolean) : void
      {
         if(this._isAutoload != param1)
         {
            this._isAutoload = param1;
            invalidateData();
         }
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidateData();
         }
      }
      
      public function get clipsType() : String
      {
         return this._currentClipsType;
      }
      
      public function set clipsType(param1:String) : void
      {
         if(this._currentClipsType != param1 && CLIPS_TYPES.hasOwnProperty(param1))
         {
            this._currentClipsType = param1;
            invalidate(INVALID_CLIPS_TYPE);
         }
      }
      
      public function get clipsDirection() : String
      {
         return this._currentClipsDirection;
      }
      
      public function set clipsDirection(param1:String) : void
      {
         if(param1 != this._currentClipsDirection && (param1 == CLIPS_LEFT_DIRECTION || param1 == CLIPS_RIGHT_DIRECTION))
         {
            this._currentClipsDirection = param1;
            invalidate(INVALID_CLIPS_DIRECTION);
         }
      }
   }
}
