package net.wg.gui.components.advanced
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.components.maintenance.data.MaintenanceShellVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ShellsSet extends UIComponentEx
   {
      
      private static const ITEMS_GAP:Number = -7;
       
      
      private var data:Array = null;
      
      private var historicalBattleID:int = -1;
      
      private var _shellViews:Array;
      
      public function ShellsSet()
      {
         this._shellViews = [];
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ShellButton = null;
         var _loc2_:MaintenanceShellVO = null;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            _loc3_ = 0;
            _loc4_ = false;
            if(this._shellViews.length != this.data.length)
            {
               this.clearRenderers();
               this._shellViews = [];
               _loc4_ = true;
            }
            _loc5_ = 0;
            while(_loc5_ < this.data.length)
            {
               _loc2_ = this.data[_loc5_];
               if(_loc4_)
               {
                  _loc1_ = App.utils.classFactory.getComponent(Linkages.SHELL_BUTTON,ShellButton);
               }
               else
               {
                  _loc1_ = this._shellViews[_loc5_];
               }
               _loc1_.id = _loc2_.id;
               _loc1_.historicalBattleID = this.historicalBattleID;
               _loc1_.ammunitionType = _loc2_.type;
               _loc1_.icon = _loc2_.icon;
               _loc1_.count = String(_loc2_.count);
               _loc1_.label = _loc2_.label;
               _loc1_.validateNow();
               if(_loc4_)
               {
                  _loc1_.x = _loc3_;
                  _loc3_ += _loc1_.width + ITEMS_GAP;
                  addChild(_loc1_);
                  this._shellViews.push(_loc1_);
               }
               _loc5_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.data)
         {
            this.data.splice(0);
            this.data = null;
         }
         this.clearRenderers();
         super.onDispose();
      }
      
      public function setData(param1:Array, param2:int = -1) : void
      {
         this.data = param1;
         this.historicalBattleID = param2;
         invalidateData();
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:ShellButton = null;
         for each(_loc1_ in this._shellViews)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._shellViews = this._shellViews.splice(0);
         this._shellViews = null;
      }
   }
}
