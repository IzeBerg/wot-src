package net.wg.gui.battle.commander.views.vehiclesPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VehiclesPanelItemBG extends BattleUIComponent
   {
      
      private static const FRAME_DEFAULT:String = "default";
      
      private static const FRAME_HOVER:String = "hover";
      
      private static const FRAME_SELECTED:String = "selected";
      
      private static const FRAME_DESTROYED:String = "destroyed";
       
      
      private var _isAlive:Boolean;
      
      private var _isSelected:Boolean;
      
      private var _isFocus:Boolean;
      
      public function VehiclesPanelItemBG()
      {
         super();
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidateData();
         }
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected != param1)
         {
            this._isSelected = param1;
            invalidateData();
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isFocus(param1:Boolean) : void
      {
         if(this._isFocus != param1)
         {
            this._isFocus = param1;
            invalidateData();
         }
      }
      
      public function get isFocus() : Boolean
      {
         return this._isFocus;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(!this.isAlive)
            {
               gotoAndStop(FRAME_DESTROYED);
            }
            else if(this.isSelected)
            {
               gotoAndStop(FRAME_SELECTED);
            }
            else if(this.isFocus)
            {
               gotoAndStop(FRAME_HOVER);
            }
            else
            {
               gotoAndStop(FRAME_DEFAULT);
            }
         }
      }
   }
}
