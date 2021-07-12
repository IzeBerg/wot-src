package scaleform.clik.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ResizeEvent;
   
   public class Constraints extends EventDispatcher implements IDisposable
   {
      
      public static const LEFT:uint = 1;
      
      public static const RIGHT:uint = 2;
      
      public static const TOP:uint = 4;
      
      public static const BOTTOM:uint = 8;
      
      public static var ALL:uint = LEFT | RIGHT | TOP | BOTTOM;
      
      public static const CENTER_H:uint = 16;
      
      public static const CENTER_V:uint = 32;
       
      
      public var scope:DisplayObject;
      
      public var scaleMode:String = "counterScale";
      
      public var parentXAdjust:Number = 1;
      
      public var parentYAdjust:Number = 1;
      
      protected var elements:Object;
      
      protected var elementCount:int = 0;
      
      protected var parentConstraints:Constraints;
      
      public var lastWidth:Number = NaN;
      
      public var lastHeight:Number = NaN;
      
      public function Constraints(param1:Sprite, param2:String = "counterScale")
      {
         super();
         this.scope = param1;
         this.scaleMode = param2;
         this.elements = {};
         this.lastWidth = param1.width;
         this.lastHeight = param1.height;
         param1.addEventListener(Event.ADDED_TO_STAGE,this.handleScopeAddedToStage,false,0,true);
         param1.addEventListener(Event.REMOVED_FROM_STAGE,this.handleScopeAddedToStage,false,0,true);
      }
      
      public function addElement(param1:String, param2:DisplayObject, param3:uint) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:Number = this.scope.width;
         var _loc5_:Number = this.scope.height;
         if(this.scope.parent != null && this.scope.parent is Stage)
         {
            _loc4_ = this.scope.stage.stageWidth;
            _loc5_ = this.scope.stage.stageHeight;
         }
         var _loc6_:ConstrainedElement = new ConstrainedElement(param2,param3,param2.x,param2.y,_loc4_ / this.scope.scaleX - (param2.x + param2.width),_loc5_ / this.scope.scaleY - (param2.y + param2.height),param2.scaleX,param2.scaleY);
         if(this.elements[param1] == null)
         {
            ++this.elementCount;
         }
         this.elements[param1] = _loc6_;
      }
      
      public function removeElement(param1:String) : void
      {
         if(this.elements[param1] != null)
         {
            --this.elementCount;
         }
         delete this.elements[param1];
      }
      
      public function removeAllElements() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this.elements)
         {
            if(this.elements[_loc1_] is ConstrainedElement)
            {
               --this.elementCount;
               delete this.elements[_loc1_];
            }
         }
      }
      
      public function getElement(param1:String) : ConstrainedElement
      {
         return this.elements[param1] as ConstrainedElement;
      }
      
      public function updateElement(param1:String, param2:DisplayObject) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:ConstrainedElement = this.elements[param1] as ConstrainedElement;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.clip = param2;
      }
      
      public function getXAdjust() : Number
      {
         if(this.scaleMode == ConstrainMode.REFLOW)
         {
            return this.parentXAdjust;
         }
         return this.parentXAdjust / this.scope.scaleX;
      }
      
      public function getYAdjust() : Number
      {
         if(this.scaleMode == ConstrainMode.REFLOW)
         {
            return this.parentYAdjust;
         }
         return this.parentYAdjust / this.scope.scaleY;
      }
      
      public function update(param1:Number, param2:Number) : void
      {
         var _loc6_:* = null;
         var _loc7_:ConstrainedElement = null;
         var _loc8_:uint = 0;
         var _loc9_:DisplayObject = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         this.lastWidth = param1;
         this.lastHeight = param2;
         if(this.elementCount == 0)
         {
            return;
         }
         var _loc3_:Number = this.getXAdjust();
         var _loc4_:Number = this.getYAdjust();
         var _loc5_:Boolean = this.scaleMode == ConstrainMode.COUNTER_SCALE;
         for(_loc6_ in this.elements)
         {
            _loc7_ = this.elements[_loc6_] as ConstrainedElement;
            _loc8_ = _loc7_.edges;
            _loc9_ = _loc7_.clip;
            if(_loc5_)
            {
               _loc9_.scaleX = _loc7_.scaleX * _loc3_;
               _loc9_.scaleY = _loc7_.scaleY * _loc4_;
               if((_loc8_ & Constraints.CENTER_H) == 0)
               {
                  if((_loc8_ & Constraints.LEFT) > 0)
                  {
                     _loc9_.x = _loc7_.left * _loc3_;
                     if((_loc8_ & Constraints.RIGHT) > 0)
                     {
                        _loc10_ = param1 - _loc7_.left - _loc7_.right;
                        if(!(_loc9_ is TextField))
                        {
                           _loc10_ *= _loc3_;
                        }
                        _loc9_.width = _loc10_;
                     }
                  }
                  else if((_loc8_ & Constraints.RIGHT) > 0)
                  {
                     _loc9_.x = (param1 - _loc7_.right) * _loc3_ - _loc9_.width;
                  }
               }
               if((_loc8_ & Constraints.CENTER_V) == 0)
               {
                  if((_loc8_ & Constraints.TOP) > 0)
                  {
                     _loc9_.y = _loc7_.top * _loc4_;
                     if((_loc8_ & Constraints.BOTTOM) > 0)
                     {
                        _loc11_ = param2 - _loc7_.top - _loc7_.bottom;
                        if(!(_loc9_ is TextField))
                        {
                           _loc11_ *= _loc4_;
                        }
                        _loc9_.height = _loc11_;
                     }
                  }
                  else if((_loc8_ & Constraints.BOTTOM) > 0)
                  {
                     _loc9_.y = (param2 - _loc7_.bottom) * _loc4_ - _loc9_.height;
                  }
               }
            }
            else
            {
               if((_loc8_ & Constraints.CENTER_H) == 0 && (_loc8_ & Constraints.RIGHT) > 0)
               {
                  if((_loc8_ & Constraints.LEFT) > 0)
                  {
                     _loc9_.width = param1 - _loc7_.left - _loc7_.right;
                  }
                  else
                  {
                     _loc9_.x = param1 - _loc9_.width - _loc7_.right;
                  }
               }
               if((_loc8_ & Constraints.CENTER_V) == 0 && (_loc8_ & Constraints.BOTTOM) > 0)
               {
                  if((_loc8_ & Constraints.TOP) > 0)
                  {
                     _loc9_.height = param2 - _loc7_.top - _loc7_.bottom;
                  }
                  else
                  {
                     _loc9_.y = param2 - _loc9_.height - _loc7_.bottom;
                  }
               }
               if(_loc9_ is UIComponent)
               {
                  (_loc9_ as UIComponent).validateNow();
               }
            }
            if((_loc8_ & Constraints.CENTER_H) > 0)
            {
               _loc9_.x = param1 * 0.5 * _loc3_ - _loc9_.width * 0.5;
            }
            if((_loc8_ & Constraints.CENTER_V) > 0)
            {
               _loc9_.y = param2 * 0.5 * _loc4_ - _loc9_.height * 0.5;
            }
         }
         if(!_loc5_)
         {
            this.scope.scaleX = this.parentXAdjust;
            this.scope.scaleY = this.parentYAdjust;
            this.scope.width = this.lastWidth;
            this.scope.height = this.lastHeight;
         }
         if(hasEventListener(ResizeEvent.RESIZE))
         {
            dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE,_loc3_,_loc4_));
         }
      }
      
      override public function toString() : String
      {
         var _loc3_:* = null;
         var _loc1_:uint = this.elements.length;
         var _loc2_:String = "[CLIK Constraints (" + _loc1_ + ")]";
         for(_loc3_ in this.elements)
         {
            _loc2_ += "\n\t" + _loc3_ + ": " + this.elements[_loc3_].toString();
         }
         return _loc2_;
      }
      
      protected function handleScopeAddedToStage(param1:Event) : void
      {
         this.addToParentConstraints();
      }
      
      protected function addToParentConstraints() : void
      {
         if(this.parentConstraints != null)
         {
            this.parentConstraints.removeEventListener(ResizeEvent.RESIZE,this.handleParentConstraintsResize);
         }
         this.parentConstraints = null;
         var _loc1_:DisplayObjectContainer = this.scope.parent;
         if(_loc1_ == null)
         {
            return;
         }
         while(_loc1_ != null)
         {
            if(_loc1_.hasOwnProperty("constraints"))
            {
               this.parentConstraints = _loc1_["constraints"] as Constraints;
               if(this.parentConstraints != null && this.parentConstraints.scaleMode == ConstrainMode.REFLOW)
               {
                  return;
               }
               if(this.parentConstraints != null && this.scaleMode == ConstrainMode.REFLOW)
               {
                  return;
               }
               if(this.parentConstraints != null)
               {
                  this.parentConstraints.addEventListener(ResizeEvent.RESIZE,this.handleParentConstraintsResize,false,0,true);
                  break;
               }
            }
            _loc1_ = _loc1_.parent;
         }
         if(this.parentConstraints != null)
         {
            this.parentXAdjust = this.parentConstraints.getXAdjust();
            this.parentYAdjust = this.parentConstraints.getYAdjust();
         }
      }
      
      protected function handleParentConstraintsResize(param1:ResizeEvent) : void
      {
         this.parentXAdjust = param1.scaleX;
         this.parentYAdjust = param1.scaleY;
         this.update(this.lastWidth,this.lastHeight);
      }
      
      public function dispose() : void
      {
         if(this.scope)
         {
            this.scope.removeEventListener(Event.ADDED_TO_STAGE,this.handleScopeAddedToStage,false);
            this.scope.removeEventListener(Event.REMOVED_FROM_STAGE,this.handleScopeAddedToStage,false);
            this.scope = null;
         }
         if(this.parentConstraints)
         {
            this.parentConstraints.removeEventListener(ResizeEvent.RESIZE,this.handleParentConstraintsResize);
            this.parentConstraints = null;
         }
      }
   }
}
