package net.wg.gui.components.controls.tabs
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class OrangeTabButton extends SoundListItemRenderer
   {
      
      private static const INVALIDATE_LAST_RENDERER:String = "lastRenderer";
      
      private static const ANIMATION_DURATION:Number = 200;
       
      
      public var background:Sprite;
      
      public var hover:Sprite;
      
      public var activeBG:Sprite;
      
      public var active:Sprite;
      
      public var separator:Sprite;
      
      public var leftSelection:Sprite;
      
      public var rightSelection:Sprite;
      
      public var textFieldSelected:TextField;
      
      private var _tweens:Vector.<Tween>;
      
      private var _isLastRenderer:Boolean;
      
      public function OrangeTabButton()
      {
         preventAutosizing = true;
         constraintsDisabled = true;
         toggle = true;
         allowDeselect = false;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.clearListeners();
         this.disposeTweens();
         _owner = null;
         _data = null;
         this._tweens = null;
         textField = null;
         this.background = null;
         this.hover = null;
         this.activeBG = null;
         this.active = null;
         this.separator = null;
         this.leftSelection = null;
         this.rightSelection = null;
         this.textFieldSelected = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.background;
         this._tweens = new Vector.<Tween>(0);
         textField.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldSelected.autoSize = TextFieldAutoSize.LEFT;
         mouseChildren = false;
      }
      
      override protected function setState(param1:String) : void
      {
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(INVALIDATE_LAST_RENDERER))
         {
            this.separator.visible = !this.isLastRenderer && !selected;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.active.visible = selected;
            this.leftSelection.visible = selected;
            this.rightSelection.visible = selected;
            this.separator.visible = !this.isLastRenderer && !selected;
            buttonMode = useHandCursor = !selected && enabled;
            this.disposeTweens();
            this.activeBG.alpha = this.textFieldSelected.alpha = !!selected ? Number(1) : Number(0);
            textField.alpha = !!selected ? Number(0) : Number(1);
            if(selected)
            {
               this.hover.alpha = 0;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = textField.x * 2 + textField.width;
            this.background.width = this.hover.width = this.activeBG.width = _loc1_;
            this.active.x = _loc1_ - this.active.width >> 1;
            this.separator.x = _loc1_;
            this.leftSelection.x = 0;
            this.rightSelection.x = _loc1_ - this.rightSelection.width;
         }
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(_label)
         {
            this.textFieldSelected.text = _label;
         }
      }
      
      private function clearListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         buttonMode = useHandCursor = param1 && !selected;
         if(param1)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         }
         else
         {
            this.clearListeners();
         }
      }
      
      override public function get width() : Number
      {
         return this.background.width;
      }
      
      override public function get height() : Number
      {
         return this.background.height;
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         return this.background.getBounds(param1);
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected != param1)
         {
            invalidate(InvalidationType.SELECTED_INDEX);
         }
         super.selected = param1;
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         invalidateData();
      }
      
      public function get isLastRenderer() : Boolean
      {
         return this._isLastRenderer;
      }
      
      public function set isLastRenderer(param1:Boolean) : void
      {
         if(this._isLastRenderer == param1)
         {
            return;
         }
         this._isLastRenderer = param1;
         invalidate(INVALIDATE_LAST_RENDERER);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.disposeTweens();
         if(!selected)
         {
            this._tweens.push(new Tween(ANIMATION_DURATION,this.hover,{"alpha":1},{"fastTransform":false}),new Tween(ANIMATION_DURATION,this.textFieldSelected,{"alpha":0.8},{"fastTransform":false}),new Tween(ANIMATION_DURATION,textField,{"alpha":0},{"fastTransform":false}));
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.disposeTweens();
         if(!selected)
         {
            this._tweens.push(new Tween(ANIMATION_DURATION,this.hover,{"alpha":0},{"fastTransform":false}),new Tween(ANIMATION_DURATION,this.textFieldSelected,{"alpha":0},{"fastTransform":false}),new Tween(ANIMATION_DURATION,textField,{"alpha":1},{"fastTransform":false}));
         }
      }
   }
}
