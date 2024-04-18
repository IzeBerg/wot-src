package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.Sprite;
   import scaleform.clik.constants.InvalidationType;
   
   public class DebutBoxHeaderTitleBlock extends CollapsedHeaderTitleBlock
   {
       
      
      private var _isEnabled:Boolean;
      
      public var toggleDivider:Sprite;
      
      public function DebutBoxHeaderTitleBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.toggleDivider = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            collapsedToggleBtn.visible = this._isEnabled;
            this.toggleDivider.visible = this._isEnabled;
            mouseEnabled = this._isEnabled;
         }
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         if(this._isEnabled != param1)
         {
            this._isEnabled = param1;
            invalidateData();
         }
      }
   }
}
