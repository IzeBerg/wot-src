package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.personalMissions.data.OperationVO;
   import net.wg.gui.lobby.personalMissions.events.ChainEvent;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class OperationsContainer extends UIComponentEx
   {
      
      private static var _arrowX:int = -1;
      
      private static var _selectedIndex:int = -1;
      
      private static var _firstShowInSession:Boolean = true;
      
      private static const RENDERER_TOP_POS:int = 2;
      
      private static const SEPARATOR_TOP:int = 44;
      
      private static const SEPARATOR_GAP_LEFT:int = 25;
      
      private static const SEPARATOR_GAP_RIGHT:int = 5;
      
      private static const SEPARATOR_ALPHA_DEF:Number = 1;
      
      private static const SEPARATOR_ALPHA_LOCKED:Number = 0.6;
      
      private static const ARROW_LEFT:int = 0;
      
      private static const DEF_TWEEN_DURATION:int = 300;
      
      private static const ARROW_TWEEN_DURATION:int = 250;
       
      
      public var arrow:DisplayObject;
      
      private var _operations:Vector.<Operation> = null;
      
      private var _separators:Vector.<DisplayObject> = null;
      
      private var _data:Vector.<OperationVO>;
      
      private var _selectedOperation:Operation = null;
      
      private var _tweenDurationMul:int = 1;
      
      private var _selectedID:Number = -1;
      
      private var _tweensDict:Dictionary;
      
      private var _firstShow:Boolean = true;
      
      public function OperationsContainer()
      {
         this._tweensDict = new Dictionary(true);
         super();
         this._operations = new Vector.<Operation>();
         this._separators = new Vector.<DisplayObject>();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         this.arrow = null;
         this._selectedOperation = null;
         this.removeOperations(0,this._operations.length);
         this._operations = null;
         this.removeSeparators(0,this._separators.length);
         this._separators = null;
         this._data = null;
         for each(_loc1_ in this._tweensDict)
         {
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._tweensDict);
         this._tweensDict = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.length;
            _loc2_ = this._operations.length;
            _loc3_ = this._separators.length;
            if(_loc2_ > _loc1_)
            {
               this.removeOperations(_loc1_,_loc2_ - _loc1_);
               this.removeSeparators(_loc1_ - 1,_loc2_ - _loc1_);
            }
            else if(_loc2_ < _loc1_)
            {
               this.createSeparators(_loc1_ - _loc3_ - 1);
               this.createOperations(_loc1_ - _loc2_);
            }
            this.updateContent();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutContent();
         }
      }
      
      public function layoutContent() : void
      {
         var _loc2_:Operation = null;
         var _loc3_:DisplayObject = null;
         var _loc1_:int = this._operations.length;
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = this._operations[_loc5_];
            _loc2_.validateNow();
            _loc2_.y = RENDERER_TOP_POS;
            this.playTween(_loc2_,_loc4_,DEF_TWEEN_DURATION,this._firstShow);
            if(_loc2_.selected)
            {
               if(_selectedIndex != _loc5_)
               {
                  this._tweenDurationMul = Math.abs(_selectedIndex - _loc5_);
                  _selectedIndex = _loc5_;
                  this._selectedOperation = _loc2_;
                  if(!_firstShowInSession)
                  {
                     this.arrow.x = _arrowX;
                  }
                  this.arrowTween(_loc4_,_firstShowInSession);
               }
               else if(this._firstShow)
               {
                  this.arrow.x = _loc4_;
               }
            }
            _loc4_ += _loc2_.width;
            if(_loc5_ < _loc1_ - 1)
            {
               _loc3_ = this._separators[_loc5_];
               _loc3_.y = SEPARATOR_TOP;
               _loc4_ += !!_loc2_.selected ? 0 : SEPARATOR_GAP_LEFT;
               this.playTween(_loc3_,_loc4_,DEF_TWEEN_DURATION,this._firstShow);
               _loc4_ += _loc3_.width + (!!_loc2_.selected ? 0 : SEPARATOR_GAP_RIGHT);
            }
            _loc5_++;
         }
         this._firstShow = _firstShowInSession = false;
         dispatchEvent(new OperationEvent(OperationEvent.SIZE_CHANGED));
      }
      
      public function setData(param1:Vector.<OperationVO>) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._selectedID = Values.DEFAULT_INT;
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onTweenCompleteHandler(param1:Tween) : void
      {
         param1.dispose();
      }
      
      private function arrowTween(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = param1 - (this.arrow.width - this._selectedOperation.width >> 1) - ARROW_LEFT;
         this.playTween(this.arrow,_loc3_,ARROW_TWEEN_DURATION * this._tweenDurationMul,param2);
         _arrowX = _loc3_;
      }
      
      private function playTween(param1:Object, param2:int, param3:int, param4:Boolean = true) : void
      {
         var _loc5_:String = null;
         var _loc6_:Tween = null;
         if(param4)
         {
            param1.x = param2;
         }
         else
         {
            _loc5_ = param1.name;
            _loc6_ = this._tweensDict[_loc5_];
            if(_loc6_)
            {
               _loc6_.dispose();
            }
            this._tweensDict[param1.name] = new Tween(param3,param1,{"x":param2},{
               "ease":Cubic.easeInOut,
               "paused":false,
               "onComplete":this.onTweenCompleteHandler
            });
         }
      }
      
      private function updateContent() : void
      {
         var _loc2_:Operation = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:OperationVO = null;
         var _loc1_:int = this._operations.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = this._operations[_loc5_];
            _loc4_ = this._data[_loc5_];
            _loc2_.update(_loc4_);
            if(_loc5_ > 0)
            {
               _loc3_ = this._separators[_loc5_ - 1];
               _loc3_.alpha = !!_loc4_.isLocked() ? Number(SEPARATOR_ALPHA_LOCKED) : Number(SEPARATOR_ALPHA_DEF);
            }
            if(_loc4_.isSelected)
            {
               this._selectedID = _loc4_.id;
            }
            _loc5_++;
         }
      }
      
      private function createOperations(param1:int) : void
      {
         var _loc2_:Operation = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = App.utils.classFactory.getComponent(Linkages.PM_HEADER_OPERATION_UI,Operation);
            _loc2_.addEventListener(OperationEvent.CLICK,this.onOperationClickHandler);
            this._operations.push(_loc2_);
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function removeOperations(param1:int, param2:int) : void
      {
         var _loc4_:Tween = null;
         var _loc5_:String = null;
         var _loc6_:Operation = null;
         var _loc3_:Vector.<Operation> = this._operations.splice(param1,param2);
         for each(_loc6_ in _loc3_)
         {
            _loc5_ = _loc6_.name;
            _loc4_ = this._tweensDict[_loc5_];
            if(_loc4_)
            {
               _loc4_.dispose();
               delete this._tweensDict[_loc5_];
            }
            _loc6_.removeEventListener(OperationEvent.CLICK,this.onOperationClickHandler);
            removeChild(_loc6_);
            _loc6_.dispose();
         }
      }
      
      private function createSeparators(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = App.utils.classFactory.getComponent(Linkages.PM_HEADER_SEPARATOR_UI,Sprite);
            this._separators.push(DisplayObject(_loc2_));
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function removeSeparators(param1:int, param2:int) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc3_:Vector.<DisplayObject> = this._separators.splice(param1,param2);
         for each(_loc4_ in _loc3_)
         {
            removeChild(_loc4_);
         }
      }
      
      public function get selectedID() : Number
      {
         return this._selectedID;
      }
      
      private function onOperationClickHandler(param1:OperationEvent) : void
      {
         var _loc2_:Operation = null;
         for each(_loc2_ in this._operations)
         {
            _loc2_.selected = false;
         }
         _loc2_ = Operation(param1.target);
         _loc2_.selected = true;
         this.layoutContent();
         this._selectedID = _loc2_.id;
         dispatchEvent(new ChainEvent(ChainEvent.CHAIN_CHANGED,this._selectedID));
      }
   }
}
