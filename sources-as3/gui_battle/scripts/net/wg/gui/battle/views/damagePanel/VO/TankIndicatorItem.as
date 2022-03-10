package net.wg.gui.battle.views.damagePanel.VO
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.ItemWithModules;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankRotator;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TankIndicatorItem implements IDisposable
   {
       
      
      public var turret:ItemWithModules;
      
      public var hull:TankRotator;
      
      public var gun:DamagePanelItemFrameStates;
      
      public var turretLinkage:String = "";
      
      public var hullLinkage:String = "";
      
      private var _disposed:Boolean = false;
      
      public function TankIndicatorItem(param1:String, param2:String)
      {
         super();
         this.turretLinkage = param1;
         this.hullLinkage = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.turret != null)
         {
            this.turret.dispose();
         }
         this.turret = null;
         if(this.hull != null)
         {
            this.hull.dispose();
         }
         this.hull = null;
         if(this.gun != null)
         {
            this.gun.dispose();
         }
         this.gun = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
