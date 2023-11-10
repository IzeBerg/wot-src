package net.wg.gui.lobby.techtree.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ComponentEvent;
   
   public class FadeComponent extends UIComponentEx implements ITutorialCustomComponent
   {
      
      private static const ENABLE_FRAME_LABEL:String = "enable";
      
      private static const DISABLE_FRAME_LABEL:String = "disable";
       
      
      private var _enabled:Boolean = false;
      
      public function FadeComponent()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         _labelHash = UIComponent.generateLabelHash(this);
         _originalWidth = super.width / super.scaleX;
         _originalHeight = super.height / super.scaleY;
         if(_width == 0)
         {
            _width = super.width;
         }
         if(_height == 0)
         {
            _height = super.height;
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.updateEnabledState(this._enabled);
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return this._enabled;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return null;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return false;
      }
      
      protected function updateEnabledState(param1:Boolean) : void
      {
         if(param1)
         {
            gotoAndPlay(ENABLE_FRAME_LABEL);
         }
         else
         {
            gotoAndPlay(DISABLE_FRAME_LABEL);
         }
      }
      
      override public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == this._enabled)
         {
            return;
         }
         super.enabled = param1;
         this._enabled = param1;
         invalidateState();
         dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
      }
   }
}
