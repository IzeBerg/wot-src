package net.wg.gui.battle.commander.views.spawnMenu.items.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VehicleItemBG extends BattleUIComponent
   {
      
      private static const HOVER_POSTFIX:String = "_hover";
      
      private static const FRAME_DEFAULT:String = "default";
      
      private static const FRAME_SELECTED:String = "selected";
      
      private static const FRAME_DESTROYED:String = "destroyed";
      
      private static const FRAME_INSTALLED:String = "installed";
       
      
      private var _isAlive:Boolean;
      
      private var _isSelected:Boolean;
      
      private var _isFocus:Boolean;
      
      private var _isInstalled:Boolean;
      
      public function VehicleItemBG()
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
      
      public function set isInstalled(param1:Boolean) : void
      {
         if(this._isInstalled != param1)
         {
            this._isInstalled = param1;
            invalidateData();
         }
      }
      
      public function get isInstalled() : Boolean
      {
         return this._isInstalled;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = FRAME_DEFAULT;
            if(!this.isAlive)
            {
               _loc1_ = FRAME_DESTROYED;
            }
            else
            {
               if(this.isSelected)
               {
                  _loc1_ = FRAME_SELECTED;
               }
               else if(this.isInstalled)
               {
                  _loc1_ = FRAME_INSTALLED;
               }
               if(this.isFocus)
               {
                  _loc1_ += HOVER_POSTFIX;
               }
            }
            gotoAndStop(_loc1_);
         }
      }
   }
}
