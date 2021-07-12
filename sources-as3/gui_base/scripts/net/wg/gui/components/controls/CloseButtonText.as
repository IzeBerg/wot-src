package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.SoundTypes;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class CloseButtonText extends SoundButtonEx
   {
      
      private static const VISIBLE_TEXT_INVALID:String = "visible_text_invalid";
      
      private static const ICON_OFFSET:int = 3;
      
      private static const HIT_MC_POS_X:int = 10;
       
      
      public var iconContainer:MovieClip;
      
      public var shineMc:MovieClip;
      
      private var _iconPosition:String = "right";
      
      private var _visibleText:Boolean = true;
      
      private var _currentVisibleText:Boolean = true;
      
      private var _iconContainerLabels:Object;
      
      public function CloseButtonText()
      {
         super();
         soundType = SoundTypes.CLOSE_WINDOW;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._iconContainerLabels = UIComponent.generateLabelHash(this.iconContainer);
         preventAutosizing = true;
         filtersMC.textField.autoSize = true;
         _deferredDispose = true;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               App.utils.asserter.assert(this._iconContainerLabels[_newFrame],"Not found state " + _newFrame);
               this.iconContainer.gotoAndPlay(_newFrame);
            }
         }
         super.draw();
         if(isInvalid(VISIBLE_TEXT_INVALID))
         {
            this.updateTextVisability();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.iconPosition == IconTextPosition.RIGHT)
            {
               this.iconContainer.x = !!this._visibleText ? Number(filtersMC.width - ICON_OFFSET ^ 0) : Number(0);
               hitMc.x = !!this._visibleText ? Number(-HIT_MC_POS_X) : Number(0);
               hitMc.width = this.iconContainer.x + this.iconContainer.width + (!!this._visibleText ? HIT_MC_POS_X : 0);
               this.setSize(hitMc.width - HIT_MC_POS_X,hitMc.height);
            }
            else
            {
               this.iconContainer.x = 0;
               if(this._visibleText)
               {
                  filtersMC.x = this.iconContainer.width + ICON_OFFSET ^ 0;
                  this.shineMc.x = filtersMC.x;
                  hitMc.x = 0;
                  hitMc.width = this.iconContainer.width + (filtersMC.width + filtersMC.x);
                  this.setSize(hitMc.width - HIT_MC_POS_X,hitMc.height);
               }
            }
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         this.updateTextVisability();
         super.updateAfterStateChange();
      }
      
      override protected function updateText() : void
      {
         if(_label != null && filtersMC.textField != null)
         {
            filtersMC.textField.text = _label;
            invalidateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconContainer = null;
         this.shineMc = null;
         App.utils.data.cleanupDynamicObject(this._iconContainerLabels);
         this._iconContainerLabels = null;
         super.onDispose();
      }
      
      private function updateTextVisability() : void
      {
         if(this._currentVisibleText == this._visibleText)
         {
            return;
         }
         filtersMC.visible = this._visibleText;
         this.shineMc.visible = this._visibleText;
         this._currentVisibleText = this._visibleText;
      }
      
      public function get visibleText() : Boolean
      {
         return this._visibleText;
      }
      
      public function set visibleText(param1:Boolean) : void
      {
         if(this._visibleText != param1)
         {
            this._visibleText = param1;
            invalidate(VISIBLE_TEXT_INVALID);
         }
      }
      
      public function get iconPosition() : String
      {
         return this._iconPosition;
      }
      
      public function set iconPosition(param1:String) : void
      {
         if(this._iconPosition == param1)
         {
            return;
         }
         this._iconPosition = param1;
         invalidateSize();
      }
   }
}
