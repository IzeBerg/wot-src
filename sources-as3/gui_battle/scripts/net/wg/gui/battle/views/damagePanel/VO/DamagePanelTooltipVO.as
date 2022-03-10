package net.wg.gui.battle.views.damagePanel.VO
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DamagePanelTooltipVO implements IDisposable
   {
       
      
      public var turretRotator:TooltipStringByItemStateVO = null;
      
      public var engine:TooltipStringByItemStateVO = null;
      
      public var gun:TooltipStringByItemStateVO = null;
      
      public var ammoBay:TooltipStringByItemStateVO = null;
      
      public var chassis:TooltipStringByItemStateVO = null;
      
      public var wheel:TooltipStringByItemStateVO = null;
      
      public var radio:TooltipStringByItemStateVO = null;
      
      public var fuelTank:TooltipStringByItemStateVO = null;
      
      public var surveyingDevice:TooltipStringByItemStateVO = null;
      
      public var commander:TooltipStringByItemStateVO = null;
      
      public var driver:TooltipStringByItemStateVO = null;
      
      public var radioman1:TooltipStringByItemStateVO = null;
      
      public var radioman2:TooltipStringByItemStateVO = null;
      
      public var gunner1:TooltipStringByItemStateVO = null;
      
      public var gunner2:TooltipStringByItemStateVO = null;
      
      public var loader1:TooltipStringByItemStateVO = null;
      
      public var loader2:TooltipStringByItemStateVO = null;
      
      private var _disposed:Boolean = false;
      
      public function DamagePanelTooltipVO()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.turretRotator = null;
         this.engine = null;
         this.gun = null;
         this.ammoBay = null;
         this.chassis = null;
         this.wheel = null;
         this.radio = null;
         this.fuelTank = null;
         this.surveyingDevice = null;
         this.commander = null;
         this.driver = null;
         this.radioman1 = null;
         this.radioman2 = null;
         this.gunner1 = null;
         this.gunner2 = null;
         this.loader1 = null;
         this.loader2 = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
