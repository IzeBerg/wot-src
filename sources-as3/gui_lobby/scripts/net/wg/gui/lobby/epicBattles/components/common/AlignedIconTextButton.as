package net.wg.gui.lobby.epicBattles.components.common
{
   import flash.display.MovieClip;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.helpers.ComponentStatesHelper;
   import net.wg.gui.lobby.epicBattles.components.common.alignedIconTextButton.AlignedIconTextButtonMainStates;
   import scaleform.clik.core.UIComponent;
   
   public class AlignedIconTextButton extends SoundButtonEx
   {
      
      private static const ICON_OFFSET:int = 11;
      
      private static const HIT_AREA_OFFSET:int = 10;
      
      private static const VISIBLE_TEXT_INVALID:String = "visible_text_invalid";
      
      private static const ICON_POSITION_INVALID:String = "icon_position_invalid";
       
      
      public var iconContainer:MovieClip = null;
      
      public var mainStates:AlignedIconTextButtonMainStates = null;
      
      private var _iconPosition:String = "left";
      
      private var _isTextVisible:Boolean = true;
      
      private var _isCurrentTextVisible:Boolean = true;
      
      public function AlignedIconTextButton()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override protected function onDispose() : void
      {
         this.mainStates.stop();
         this.mainStates.dispose();
         this.mainStates = null;
         this.iconContainer.stop();
         this.iconContainer = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         this.mainStates.updateStatesWidth();
         this.resizeHitMc();
      }
      
      override protected function setState(param1:String) : void
      {
         super.setState(param1);
         this.iconContainer.gotoAndPlay(param1);
         this.mainStates.gotoAndPlay(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Vector.<MovieClip> = new <MovieClip>[this.mainStates,this.iconContainer];
         App.utils.asserter.assert(ComponentStatesHelper.getInstance().compareStatesLabels(_loc1_),"Timeline labels in \'mainStates\' and \'iconContainer\' must be equal!");
         _loc1_.splice(0,_loc1_.length);
         _labelHash = UIComponent.generateLabelHash(this.mainStates);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(VISIBLE_TEXT_INVALID))
         {
            this.updateTextVisibility();
            this.resizeHitMc();
         }
         if(isInvalid(ICON_POSITION_INVALID))
         {
            this.updateIconPosition();
            this.resizeHitMc();
         }
      }
      
      private function updateIconPosition() : void
      {
         if(this._iconPosition == IconTextPosition.RIGHT)
         {
            this.mainStates.x = 0;
            this.iconContainer.x = this.mainStates.x + this.mainStates.textMc.x + this.mainStates.textMc.width - ICON_OFFSET >> 0;
         }
         else if(this._iconPosition == IconTextPosition.LEFT)
         {
            this.iconContainer.x = 0;
            this.mainStates.x = this.iconContainer.x + this.iconContainer.width >> 0;
         }
      }
      
      private function updateTextVisibility() : void
      {
         if(this._isCurrentTextVisible == this._isTextVisible)
         {
            return;
         }
         this.mainStates.visible = this._isTextVisible;
         this._isCurrentTextVisible = this._isTextVisible;
      }
      
      private function resizeHitMc() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(hitMc != null)
         {
            _loc1_ = 0;
            if(this._isTextVisible)
            {
               _loc1_ = this.mainStates.x + this.mainStates.textMc.x + this.mainStates.textMc.width;
            }
            _loc2_ = this.iconContainer.x + _loc1_;
            if(this._iconPosition == IconTextPosition.RIGHT)
            {
               _loc2_ = _loc1_ + this.iconContainer.width - ICON_OFFSET;
            }
            hitMc.width = _loc2_ + HIT_AREA_OFFSET;
         }
      }
      
      override public function set label(param1:String) : void
      {
         this.mainStates.textMc.textField.text = param1;
         super.label = param1;
      }
   }
}
