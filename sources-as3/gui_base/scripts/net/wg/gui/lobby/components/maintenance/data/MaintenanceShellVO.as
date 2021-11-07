package net.wg.gui.lobby.components.maintenance.data
{
   import net.wg.data.constants.Currencies;
   import net.wg.gui.components.controls.VO.ShellButtonVO;
   import net.wg.gui.events.ShellRendererEvent;
   
   [Event(name="userCountChanged",type="net.wg.gui.events.ShellRendererEvent")]
   public class MaintenanceShellVO extends ShellButtonVO
   {
      
      private static const USER_COUNT_FIELD:String = "userCount";
       
      
      public var step:int;
      
      public var prices:Array = null;
      
      public var actionPriceData:Object = null;
      
      public var currency:String = "";
      
      public var ammoName:String = "";
      
      public var tableName:String = "";
      
      public var maxAmmo:int;
      
      public var list:Array = null;
      
      public var possibleMax:int;
      
      public var totalLoaded:int;
      
      public var userCredits:Object = null;
      
      public var desc:String = "";
      
      private var _userCount:int = -1;
      
      public function MaintenanceShellVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == USER_COUNT_FIELD)
         {
            this.setUserCount(int(param2));
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         if(this.prices)
         {
            this.prices.splice(0);
            this.prices = null;
         }
         if(this.list)
         {
            this.list.splice(0);
            this.list = null;
         }
         App.utils.data.cleanupDynamicObject(this.actionPriceData);
         this.actionPriceData = null;
         App.utils.data.cleanupDynamicObject(this.userCredits);
         this.userCredits = null;
         super.onDispose();
      }
      
      public function setUserCount(param1:int) : void
      {
         this._userCount = param1;
         dispatchEvent(new ShellRendererEvent(ShellRendererEvent.USER_COUNT_CHANGED));
      }
      
      public function get userCount() : int
      {
         return this._userCount;
      }
      
      public function set userCount(param1:int) : void
      {
         if(this._userCount == param1)
         {
            return;
         }
         this._userCount = param1;
         this.updateUserCount();
      }
      
      public function updateUserCount() : void
      {
         var _loc1_:MaintenanceShellVO = null;
         var _loc2_:int = this.userCount;
         var _loc3_:MaintenanceShellVO = null;
         for each(_loc1_ in this.list)
         {
            _loc2_ += _loc1_.userCount;
            if(_loc3_ == null || _loc1_.userCount > _loc3_.userCount)
            {
               _loc3_ = _loc1_;
            }
         }
         if(_loc2_ > this.maxAmmo)
         {
            this._userCount -= _loc2_ - this.maxAmmo;
            _loc2_ -= _loc2_ - this.maxAmmo;
         }
         var _loc4_:int = _loc2_ - this.maxAmmo;
         _loc4_ = _loc4_ > 0 ? int(_loc4_) : int(0);
         this.possibleMax = this.maxAmmo - _loc2_ + _loc4_ + this.userCount;
         for each(_loc1_ in this.list)
         {
            _loc1_.possibleMax = this.maxAmmo - _loc2_ + _loc4_ + _loc1_.userCount;
            _loc1_.setUserCount(_loc1_.userCount - (_loc1_ == _loc3_ ? _loc4_ : 0));
            _loc1_.userCredits = this.userCredits;
         }
         dispatchEvent(new ShellRendererEvent(ShellRendererEvent.USER_COUNT_CHANGED));
      }
      
      public function get price() : int
      {
         return this.prices[Currencies.INDEX_FROM_NAME[this.currency]];
      }
      
      public function get buyShellsCount() : int
      {
         var _loc1_:int = count - this.userCount + inventoryCount;
         return _loc1_ < 0 ? int(-_loc1_) : int(0);
      }
   }
}
