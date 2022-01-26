package net.wg.gui.lobby.rankedBattles19.components.divisionsContainer
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.rankedBattles19.components.DivisionIcon;
   import net.wg.gui.lobby.rankedBattles19.components.divisionStatus.DivisionStatus;
   import net.wg.gui.lobby.rankedBattles19.constants.RankedHelper;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class Division extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const SIZE_NORMAL_SMALL:int = 28;
      
      private static const SIZE_HOVER_SMALL:int = 32;
      
      private static const SIZE_SELECTED_SMALL:int = 42;
      
      private static const NAMETF_Y_SMALL:int = 28;
      
      private static const SIZE_NORMAL_BIG:int = 42;
      
      private static const SIZE_HOVER_BIG:int = 46;
      
      private static const SIZE_SELECTED_BIG:int = 56;
      
      private static const NAMETF_Y_BIG:int = 33;
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const HOVER_STATE:String = "hover";
      
      private static const SELECTED_STATE:String = "selected";
      
      private static const ICON_NORMAL_ALPHA:Number = 0.5;
      
      private static const ICON_HOVER_ALPHA:Number = 0.8;
      
      private static const ICON_SELECTED_ALPHA:Number = 1;
      
      private static const STATUS_NORMAL_POSITION_SMALL:Object = {
         "x":0,
         "y":0
      };
      
      private static const STATUS_SELECTED_POSITION_SMALL:Object = {
         "x":6,
         "y":4
      };
      
      private static const STATUS_NORMAL_POSITION_BIG:Object = {
         "x":7,
         "y":5
      };
      
      private static const STATUS_SELECTED_POSITION_BIG:Object = {
         "x":12,
         "y":10
      };
      
      private static const TWEEN_TIME_DEF:int = 250;
      
      private static const TWEEN_ICON_NORMAL_PARAMS_SMALL:Object = {
         "alpha":ICON_NORMAL_ALPHA,
         "width":SIZE_NORMAL_SMALL,
         "height":SIZE_NORMAL_SMALL
      };
      
      private static const TWEEN_ICON_HOVER_PARAMS_SMALL:Object = {
         "alpha":ICON_HOVER_ALPHA,
         "width":SIZE_HOVER_SMALL,
         "height":SIZE_HOVER_SMALL
      };
      
      private static const TWEEN_ICON_SELECTED_PARAMS_SMALL:Object = {
         "alpha":ICON_SELECTED_ALPHA,
         "width":SIZE_SELECTED_SMALL,
         "height":SIZE_SELECTED_SMALL
      };
      
      private static const TWEEN_ICON_NORMAL_PARAMS_BIG:Object = {
         "alpha":ICON_NORMAL_ALPHA,
         "width":SIZE_NORMAL_BIG,
         "height":SIZE_NORMAL_BIG
      };
      
      private static const TWEEN_ICON_HOVER_PARAMS_BIG:Object = {
         "alpha":ICON_HOVER_ALPHA,
         "width":SIZE_HOVER_BIG,
         "height":SIZE_HOVER_BIG
      };
      
      private static const TWEEN_ICON_SELECTED_PARAMS_BIG:Object = {
         "alpha":ICON_SELECTED_ALPHA,
         "width":SIZE_SELECTED_BIG,
         "height":SIZE_SELECTED_BIG
      };
      
      private static const TWEEN_NAMETF_NORMAL_PARAMS:Object = {"alpha":0};
      
      private static const TWEEN_NAMETF_SELECTED_PARAMS:Object = {"alpha":1};
       
      
      public var icon:DivisionIcon = null;
      
      public var nameTf:TextField = null;
      
      public var status:DivisionStatus = null;
      
      public var hit:Sprite = null;
      
      private var _nameContainer:Sprite = null;
      
      private var _iconTweenParamsStateNormal:Object;
      
      private var _iconTweenParamsStateHover:Object;
      
      private var _iconTweenParamsStateSelected:Object;
      
      private var _statusPositionNormal:Object;
      
      private var _statusPositionSelected:Object;
      
      private var _data:DivisionVO = null;
      
      private var _currentState:String = "normal";
      
      private var _oldState:String = null;
      
      private var _tweensPool:Vector.<Tween> = null;
      
      private var _isSmall:Boolean = false;
      
      public function Division()
      {
         this._iconTweenParamsStateNormal = TWEEN_ICON_NORMAL_PARAMS_BIG;
         this._iconTweenParamsStateHover = TWEEN_ICON_HOVER_PARAMS_BIG;
         this._iconTweenParamsStateSelected = TWEEN_ICON_SELECTED_PARAMS_BIG;
         this._statusPositionNormal = STATUS_NORMAL_POSITION_BIG;
         this._statusPositionSelected = STATUS_SELECTED_POSITION_BIG;
         super();
         this._tweensPool = new Vector.<Tween>(0);
         this._nameContainer = new Sprite();
         addChild(this._nameContainer);
         this._nameContainer.addChild(this.nameTf);
      }
      
      private static function onTweenCompleteHandler(param1:Tween) : void
      {
         param1.paused = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.allowResize = true;
         this.icon.groupID = DivisionIcon.ICON_GROUP_ID_BIG;
         this.icon.mouseChildren = this.icon.mouseEnabled = false;
         this.status.mouseChildren = this.status.mouseEnabled = false;
         this.nameTf.mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.icon.iconID = this._data.id;
            if(_baseDisposed)
            {
               return;
            }
            this.icon.visible = true;
            this.nameTf.htmlText = this._data.name;
            App.utils.commons.updateTextFieldSize(this.nameTf,true,true);
            this.nameTf.x = -(this.nameTf.width >> 1);
            this.status.visible = this._data.isCompleted || this._data.isLocked;
            if(this.status.visible)
            {
               this.status.frameLabel = RankedHelper.getDivisionStatus(false,this._data.isCompleted);
               if(_baseDisposed)
               {
                  return;
               }
            }
            invalidateState();
         }
         if(StringUtils.isNotEmpty(this._currentState) && isInvalid(InvalidationType.STATE))
         {
            this.nameTf.y = !!this._isSmall ? Number(NAMETF_Y_SMALL) : Number(NAMETF_Y_BIG);
            _loc1_ = this._currentState == SELECTED_STATE;
            hitArea = !!_loc1_ ? null : this.hit;
            buttonMode = useHandCursor = !_loc1_;
            this.completeTweens();
            if(_loc1_)
            {
               this.playTween(TWEEN_TIME_DEF,this.icon,this._iconTweenParamsStateSelected);
               this._nameContainer.alpha = 0;
               this._nameContainer.visible = true;
               this.playTween(TWEEN_TIME_DEF,this._nameContainer,TWEEN_NAMETF_SELECTED_PARAMS);
               this.playTween(TWEEN_TIME_DEF,this.status,this._statusPositionSelected);
            }
            else if(this._currentState == NORMAL_STATE)
            {
               if(this._oldState == SELECTED_STATE)
               {
                  this.playTween(TWEEN_TIME_DEF,this.icon,this._iconTweenParamsStateNormal);
                  this.playTween(TWEEN_TIME_DEF,this._nameContainer,TWEEN_NAMETF_NORMAL_PARAMS,{
                     "paused":false,
                     "onComplete":this.onTweenNameTfNormalCompleteHandler
                  });
                  this.playTween(TWEEN_TIME_DEF,this.status,this._statusPositionNormal);
               }
               else if(this._oldState == HOVER_STATE)
               {
                  this.playTween(TWEEN_TIME_DEF,this.icon,this._iconTweenParamsStateNormal);
               }
               else
               {
                  this.icon.alpha = ICON_NORMAL_ALPHA;
                  this.icon.width = this.icon.height = !!this._isSmall ? Number(SIZE_NORMAL_SMALL) : Number(SIZE_NORMAL_BIG);
                  this._nameContainer.visible = false;
                  if(this.status.visible)
                  {
                     this.status.x = this._statusPositionNormal.x;
                     this.status.y = this._statusPositionNormal.y;
                  }
               }
            }
            else if(this._currentState == HOVER_STATE)
            {
               this.playTween(TWEEN_TIME_DEF,this.icon,this._iconTweenParamsStateHover);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.icon.dispose();
         this.icon = null;
         this._nameContainer.removeChild(this.nameTf);
         this.nameTf = null;
         this.status.dispose();
         this.status = null;
         this.hit = null;
         this._data = null;
         this._iconTweenParamsStateNormal = null;
         this._iconTweenParamsStateHover = null;
         this._iconTweenParamsStateSelected = null;
         this._statusPositionNormal = null;
         this._statusPositionSelected = null;
         for each(_loc1_ in this._tweensPool)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweensPool.splice(0,this._tweensPool.length);
         this._tweensPool = null;
         removeChild(this._nameContainer);
         this._nameContainer = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = DivisionVO(param1);
            invalidateData();
         }
      }
      
      private function playTween(param1:Number, param2:Object, param3:Object, param4:Object = null) : void
      {
         if(param4 == null)
         {
            param4 = {
               "paused":false,
               "onComplete":onTweenCompleteHandler
            };
         }
         this._tweensPool.push(new Tween(param1,param2,param3,param4));
      }
      
      private function completeTweens() : void
      {
         var _loc1_:Tween = null;
         while(this._tweensPool.length > 0)
         {
            _loc1_ = this._tweensPool.pop();
            if(!_loc1_.paused)
            {
               _loc1_.onComplete(_loc1_);
            }
            _loc1_.paused = true;
            _loc1_.dispose();
         }
      }
      
      private function onTweenNameTfNormalCompleteHandler(param1:Tween) : void
      {
         this._nameContainer.visible = false;
         onTweenCompleteHandler(param1);
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? SELECTED_STATE : NORMAL_STATE;
         if(this._currentState != _loc2_)
         {
            this._oldState = this._currentState;
            this._currentState = _loc2_;
            invalidateState();
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            if(this._isSmall)
            {
               this.icon.groupID = DivisionIcon.ICON_GROUP_ID_MEDIUM;
               this._iconTweenParamsStateNormal = TWEEN_ICON_NORMAL_PARAMS_SMALL;
               this._iconTweenParamsStateHover = TWEEN_ICON_HOVER_PARAMS_SMALL;
               this._iconTweenParamsStateSelected = TWEEN_ICON_SELECTED_PARAMS_SMALL;
               this._statusPositionNormal = STATUS_NORMAL_POSITION_SMALL;
               this._statusPositionSelected = STATUS_SELECTED_POSITION_SMALL;
            }
            else
            {
               this.icon.groupID = DivisionIcon.ICON_GROUP_ID_BIG;
               this._iconTweenParamsStateNormal = TWEEN_ICON_NORMAL_PARAMS_BIG;
               this._iconTweenParamsStateHover = TWEEN_ICON_HOVER_PARAMS_BIG;
               this._iconTweenParamsStateSelected = TWEEN_ICON_SELECTED_PARAMS_BIG;
               this._statusPositionNormal = STATUS_NORMAL_POSITION_BIG;
               this._statusPositionSelected = STATUS_SELECTED_POSITION_BIG;
            }
            this._oldState = NORMAL_STATE;
            invalidateState();
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this._currentState != SELECTED_STATE)
         {
            this._oldState = this._currentState;
            this._currentState = NORMAL_STATE;
            invalidateState();
         }
         App.toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._currentState != SELECTED_STATE)
         {
            this._oldState = this._currentState;
            this._currentState = HOVER_STATE;
            invalidateState();
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.RANKED_BATTLES_DIVISION,null);
         }
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_DIVISION_INFO,null,this._data.id,this._data.isCurrent,this._data.isLocked,this._data.isCompleted);
      }
   }
}
