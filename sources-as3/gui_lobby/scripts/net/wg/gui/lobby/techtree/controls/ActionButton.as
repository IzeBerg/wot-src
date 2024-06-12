package net.wg.gui.lobby.techtree.controls
{
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ActionName;
   import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.utils.ImageSubstitution;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class ActionButton extends SoundButton
   {
      
      public static const DEFAULT_IMAGE_SUBSTITUTION:Object = {
         "subString":"",
         "source":"",
         "baseLineY":0,
         "width":16,
         "height":16
      };
      
      private static const SEPARATOR:String = "_";
      
      private static const SELECTED_PREFIX:String = "selected_";
      
      private static const STATE_UP:String = "up";
      
      private static const STATE_DISABLED:String = "disabled";
      
      private static const RENDERER:String = "renderer";
       
      
      public var icon:MovieClip;
      
      public var disableIndicator:BitmapFill;
      
      private var _animProps:AnimationProperties = null;
      
      private var _animID:Number = -1;
      
      private var _animTween:Tween = null;
      
      private var _action:String = "unlock";
      
      private var _imgSubstitution:ImageSubstitution;
      
      private var _minWidth:Number;
      
      public function ActionButton()
      {
         super();
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return hitArea != null ? Boolean(hitArea.hitTestPoint(param1,param2,param3)) : Boolean(super.hitTestPoint(param1,param2,param3));
      }
      
      override protected function onBeforeDispose() : void
      {
         this.tryToClearImgSubstitution();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.resetTween();
         if(this.disableIndicator != null)
         {
            this.disableIndicator.dispose();
            this.disableIndicator = null;
         }
         if(this._animProps != null)
         {
            App.utils.data.cleanupDynamicObject(this._animProps);
            this._animProps = null;
         }
         if(this._imgSubstitution != null)
         {
            this._imgSubstitution.dispose();
            this._imgSubstitution = null;
         }
         this.icon = null;
         owner = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         _state = STATE_UP;
      }
      
      override protected function initialize() : void
      {
         this.makeStatesPrefixes();
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._minWidth = _width;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(this.disableIndicator != null && isInvalid(InvalidationType.STATE))
         {
            this.disableIndicator.visible = state == STATE_DISABLED;
         }
      }
      
      override protected function calculateWidth() : Number
      {
         var _loc1_:Number = super.calculateWidth();
         return _loc1_ > this._minWidth ? Number(_loc1_) : Number(this._minWidth);
      }
      
      override protected function updateText() : void
      {
         if(_label == null || textField == null)
         {
            return;
         }
         this.tryToClearImgSubstitution();
         if(this._imgSubstitution != null)
         {
            if(this._imgSubstitution.loadImage())
            {
               TextFieldEx.setImageSubstitutions(textField,this._imgSubstitution);
               textField.text = label + this._imgSubstitution.subString;
            }
            else
            {
               textField.text = label;
               TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_CENTER);
            }
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         this.doAction();
      }
      
      public function endAnimation(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Boolean = false;
         if(this._animProps != null)
         {
            _loc2_ = Extensions.getMouseTopMostEntity(true);
            _loc3_ = false;
            if(_loc2_ != null && owner != null)
            {
               _loc3_ = _loc2_ == owner || owner.contains(_loc2_);
            }
            if(!param1 && _loc3_ && owner.hitTestPoint(stage.mouseX,stage.mouseY,true))
            {
               return;
            }
            if(_loc3_ && this.hitTestPoint(stage.mouseX,stage.mouseY,true))
            {
               if(this._animTween != null)
               {
                  this._animTween.reset();
               }
               this._animProps.setTo(this);
            }
            else
            {
               this.resetTween();
               this._animTween = new Tween(this._animProps.duration,this,this._animProps.from,{
                  "ease":Strong.easeOut,
                  "onComplete":this.onTweenComplete,
                  "paused":false
               });
            }
         }
      }
      
      public function onTweenComplete() : void
      {
         visible = alpha > 0;
      }
      
      public function setAnimation(param1:Number, param2:AnimationProperties) : Boolean
      {
         if(this._animID == param1)
         {
            return false;
         }
         this._animID = param1;
         if(this._animProps != null)
         {
            this._animProps.setTo(this);
         }
         this._animProps = param2;
         if(param2 != null)
         {
            this._animProps.setFrom(this);
         }
         return true;
      }
      
      public function setOwner(param1:UIComponent) : void
      {
         if(_owner != param1)
         {
            _owner = param1;
            this.focusTarget = _owner;
         }
      }
      
      public function startAnimation() : void
      {
         if(this._animProps != null)
         {
            this.resetTween();
            this._animTween = new Tween(this._animProps.duration,this,this._animProps.to,{
               "ease":Strong.easeOut,
               "onComplete":this.onTweenComplete,
               "paused":false
            });
         }
      }
      
      private function resetTween() : void
      {
         if(this._animTween != null)
         {
            this._animTween.paused = true;
            this._animTween.dispose();
            this._animTween = null;
         }
         visible = true;
      }
      
      private function doAction() : void
      {
         var _loc2_:IRenderer = null;
         var _loc1_:String = null;
         switch(this._action)
         {
            case ActionName.UNLOCK:
               _loc1_ = TechTreeEvent.CLICK_2_UNLOCK;
               break;
            case ActionName.BUY:
            case ActionName.RENT:
               _loc1_ = TechTreeEvent.CLICK_2_BUY;
               break;
            case ActionName.RESTORE:
               _loc1_ = TechTreeEvent.RESTORE_VEHICLE;
         }
         if(_loc1_ != null && owner != null)
         {
            _loc2_ = owner as IRenderer;
            App.utils.asserter.assertNotNull(_loc2_,RENDERER + Errors.CANT_NULL);
            dispatchEvent(new TechTreeEvent(_loc1_,_loc2_.nodeState,_loc2_.index,_loc2_.entityType));
         }
      }
      
      private function makeStatesPrefixes() : void
      {
         var _loc1_:String = this._action + SEPARATOR;
         statesSelected = Vector.<String>([SELECTED_PREFIX,_loc1_]);
         statesDefault = Vector.<String>([_loc1_]);
      }
      
      private function tryToClearImgSubstitution() : void
      {
         if(this._imgSubstitution != null)
         {
            if(textField != null)
            {
               TextFieldEx.setImageSubstitutions(textField,null);
            }
         }
      }
      
      public function get action() : String
      {
         return this._action;
      }
      
      public function set action(param1:String) : void
      {
         if(this._action == param1)
         {
            return;
         }
         this._action = param1;
         this.makeStatesPrefixes();
         setState(this.state);
      }
      
      [Inspectable(defaultValue="subString:,source:,baseLineY:0,width:16,height:16")]
      public function set imgSubstitution(param1:Object) : void
      {
         if(!param1 || this._imgSubstitution && param1.subString == this._imgSubstitution.subString && param1.source == this._imgSubstitution.source)
         {
            return;
         }
         if(this._imgSubstitution)
         {
            this._imgSubstitution.subString = param1.subString;
            this._imgSubstitution.source = param1.source;
            this._imgSubstitution.baseLineY = param1.baseLineY;
            this._imgSubstitution.width = param1.width;
            this._imgSubstitution.height = param1.height;
         }
         else
         {
            this._imgSubstitution = new ImageSubstitution(param1.subString,param1.source,param1.baseLineY,param1.width,param1.height);
         }
         invalidateData();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         var _loc2_:IRenderer = owner as IRenderer;
         App.utils.asserter.assertNotNull(_loc2_,RENDERER + Errors.CANT_NULL);
         dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_MODULE_HOVER,_loc2_.nodeState,_loc2_.index,_loc2_.entityType));
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.endAnimation(false);
         var _loc2_:IRenderer = owner as IRenderer;
         App.utils.asserter.assertNotNull(_loc2_,RENDERER + Errors.CANT_NULL);
         dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_MODULE_HOVER,_loc2_.nodeState,-1,_loc2_.entityType));
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         super.handleReleaseOutside(param1);
         this.endAnimation(false);
      }
   }
}
