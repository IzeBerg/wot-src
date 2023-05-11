package net.wg.gui.battle.components.buttons
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.gui.battle.components.buttons.btnConfig.BattleStateBtnSettings;
   import net.wg.infrastructure.managers.IAtlasManager;
   import scaleform.clik.utils.Padding;
   
   public class BattleStateButton extends BattleToolTipButton
   {
       
      
      public var atlasName:String = "battleAtlas";
      
      public var atlasMgr:IAtlasManager = null;
      
      public var actualWidth:int = 0;
      
      public var actualHeight:int = 0;
      
      private var _upState:Vector.<Sprite> = null;
      
      private var _overState:Vector.<Sprite> = null;
      
      private var _stateMap:Dictionary;
      
      private var _outState:Vector.<Sprite> = null;
      
      private var _downState:Vector.<Sprite> = null;
      
      private var _releaseState:Vector.<Sprite> = null;
      
      private var _selectedState:Vector.<Sprite> = null;
      
      private var _emptyUPState:Vector.<Sprite> = null;
      
      private var _disabledState:Vector.<Sprite> = null;
      
      private var _latestActiveState:Vector.<Sprite> = null;
      
      private var _hitArea:Sprite = null;
      
      public function BattleStateButton()
      {
         this._stateMap = new Dictionary();
         super();
         this._upState = new Vector.<Sprite>();
         this._overState = new Vector.<Sprite>();
         this._outState = new Vector.<Sprite>();
         this._downState = new Vector.<Sprite>();
         this._releaseState = new Vector.<Sprite>();
         this._selectedState = new Vector.<Sprite>();
         this._emptyUPState = new Vector.<Sprite>();
         this._disabledState = new Vector.<Sprite>();
         this._stateMap[InteractiveStates.UP] = this._upState;
         this._stateMap[InteractiveStates.OVER] = this._overState;
         this._stateMap[InteractiveStates.OUT] = this._outState;
         this._stateMap[InteractiveStates.DOWN] = this._downState;
         this._stateMap[InteractiveStates.RELEASE] = this._releaseState;
         this._stateMap[InteractiveStates.SELECTED] = this._selectedState;
         this._stateMap[InteractiveStates.EMPTY_UP] = this._emptyUPState;
         this._stateMap[InteractiveStates.DISABLED] = this._disabledState;
      }
      
      override protected function onDispose() : void
      {
         this.clearAllStates();
         this.atlasMgr = null;
         this._stateMap = null;
         this._upState = null;
         this._overState = null;
         this._outState = null;
         this._downState = null;
         this._releaseState = null;
         this._selectedState = null;
         this._emptyUPState = null;
         this._disabledState = null;
         this._latestActiveState = null;
         this.clearHitArea();
         super.onDispose();
      }
      
      public function clearAllStates() : void
      {
         this.actualWidth = 0;
         this.actualHeight = 0;
         this.clearState(this._upState);
         this.clearState(this._overState);
         this.clearState(this._outState);
         this.clearState(this._downState);
         this.clearState(this._releaseState);
         this.clearState(this._selectedState);
         this.clearState(this._emptyUPState);
         this.clearState(this._disabledState);
      }
      
      public function setDisableState(param1:Array) : void
      {
         this.makeStates(param1,this._disabledState,InteractiveStates.DISABLED);
      }
      
      public function setOverState(param1:Array) : void
      {
         this.makeStates(param1,this._overState,InteractiveStates.OVER);
      }
      
      public function setUpOutState(param1:Array) : void
      {
         this.makeStates(param1,this._upState,InteractiveStates.UP);
         this.makeStates(param1,this._outState,InteractiveStates.OUT);
      }
      
      public function setHitArea(param1:Padding) : void
      {
         this.clearHitArea();
         this._hitArea = new Sprite();
         this._hitArea.graphics.clear();
         this._hitArea.graphics.beginFill(16711680,0);
         this._hitArea.graphics.drawRect(param1.left,param1.top,this.actualWidth - param1.horizontal,this.actualHeight - param1.vertical);
         this._hitArea.graphics.endFill();
         this.addChild(this._hitArea);
         this.hitArea = this._hitArea;
      }
      
      private function clearHitArea() : void
      {
         if(this._hitArea)
         {
            this.removeChild(this._hitArea);
            this._hitArea = null;
         }
      }
      
      private function makeStates(param1:Array, param2:Vector.<Sprite>, param3:String) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:BattleStateBtnSettings = null;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         var _loc8_:Point = null;
         if(param2 && param2.length > 0)
         {
            for each(_loc6_ in param2)
            {
               this.removeChild(_loc6_);
            }
            param2.splice(0,param2.length);
         }
         _loc4_ = _buttonState == param3;
         for each(_loc5_ in param1)
         {
            _loc7_ = new Sprite();
            if(this.atlasMgr == null)
            {
               this.atlasMgr = App.atlasMgr;
            }
            this.atlasMgr.drawGraphics(this.atlasName,_loc5_.atlasItemName,_loc7_.graphics,"");
            addChild(_loc7_);
            _loc8_ = _loc5_.offsetImagePosition;
            if(_loc8_ != null)
            {
               _loc7_.x = _loc8_.x;
               _loc7_.y = _loc8_.y;
            }
            else if(_loc5_.alignImg == BattleStateBtnSettings.ALIGN_TO_CENTER)
            {
               _loc7_.x = this.width - _loc7_.width >> 1;
               _loc7_.y = this.height - _loc7_.height >> 1;
            }
            param2.push(_loc7_);
            _loc7_.visible = _loc4_;
            if(_loc4_)
            {
               this.updateActualSize(_loc7_);
            }
         }
         if(_loc4_)
         {
            this._latestActiveState = param2;
         }
      }
      
      private function updateActualSize(param1:Sprite) : void
      {
         var _loc2_:int = param1.width;
         if(_loc2_ > this.actualWidth)
         {
            this.actualWidth = _loc2_;
         }
         var _loc3_:int = param1.height;
         if(_loc3_ > this.actualHeight)
         {
            this.actualHeight = _loc3_;
         }
      }
      
      private function changeState(param1:Vector.<Sprite>) : void
      {
         if(_isEnabled == false && param1 != this._disabledState)
         {
            return;
         }
         if(param1 != null && param1.length > 0)
         {
            this.updateStateVisibility(this._latestActiveState,false);
            this.updateStateVisibility(param1,true);
            this._latestActiveState = param1;
         }
      }
      
      private function updateStateVisibility(param1:Vector.<Sprite>, param2:Boolean) : void
      {
         var _loc3_:Sprite = null;
         if(param1 != null && param1.length > 0)
         {
            if(param2)
            {
               this.actualWidth = 0;
            }
            for each(_loc3_ in param1)
            {
               _loc3_.visible = param2;
               if(param2)
               {
                  this.updateActualSize(_loc3_);
               }
            }
         }
      }
      
      private function clearState(param1:Vector.<Sprite>) : void
      {
         var _loc2_:Sprite = null;
         if(param1 && param1.length > 0)
         {
            for each(_loc2_ in param1)
            {
               this.removeChild(_loc2_);
            }
            param1.splice(0,param1.length);
         }
      }
      
      override public function set state(param1:String) : void
      {
         super.state = param1;
         this.changeState(this._stateMap[param1]);
      }
   }
}
