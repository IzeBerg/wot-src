package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleStatusHeader extends Sprite implements IDisposable
   {
       
      
      public var battleTF:TextField = null;
      
      public var timeTF:TextField = null;
      
      public function BattleStatusHeader()
      {
         super();
         this.battleTF.text = EVENT.RESULTSCREEN_BATTLESTATUS_HEADER;
      }
      
      public final function dispose() : void
      {
         this.battleTF = null;
         this.timeTF = null;
      }
      
      public function setData(param1:ResultDataVO) : void
      {
         this.timeTF.text = param1.time;
      }
   }
}
