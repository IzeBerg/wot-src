package net.wg.gui.lobby.vehicleTradeWnds.cpmts
{
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyHeaderVo;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class VehicleTradeHeader extends UIComponentEx
   {
       
      
      public var tankNameTF:TextField = null;
      
      public var tankDescribeTF:TextField = null;
      
      public var tankLevelTF:TextField = null;
      
      public var tankIcon:TankIcon = null;
      
      public function VehicleTradeHeader()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.tankLevelTF = null;
         this.tankNameTF = null;
         this.tankDescribeTF = null;
         super.onDispose();
      }
      
      public function setData(param1:VehicleBuyHeaderVo) : void
      {
         App.utils.asserter.assertNotNull(param1,"sellData" + Errors.CANT_NULL);
         this.tankNameTF.htmlText = param1.userName;
         this.tankLevelTF.htmlText = param1.levelStr;
         this.tankDescribeTF.text = param1.description;
         this.tankIcon.image = param1.icon;
         this.tankIcon.level = param1.level;
         this.tankIcon.isElite = param1.isElite;
         this.tankIcon.isPremium = param1.isPremium;
         this.tankIcon.tankType = param1.type;
         this.tankIcon.nation = param1.nationID;
      }
   }
}
