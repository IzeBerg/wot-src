package net.wg.gui.lobby.tankman
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DropSkillsCost implements IDisposable
   {
       
      
      public var credits:int;
      
      public var gold:int;
      
      public var xpReuseFraction:Number;
      
      public var id:int;
      
      public var actionPriceDataVo:ActionPriceVO;
      
      private var _disposed:Boolean = false;
      
      public function DropSkillsCost(param1:Object)
      {
         super();
         this.gold = param1.gold;
         this.credits = param1.credits;
         this.xpReuseFraction = param1.xpReuseFraction;
         this.actionPriceDataVo = Boolean(param1.action) ? new ActionPriceVO(param1.action) : null;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.actionPriceDataVo)
         {
            this.actionPriceDataVo.dispose();
         }
         this.actionPriceDataVo = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
