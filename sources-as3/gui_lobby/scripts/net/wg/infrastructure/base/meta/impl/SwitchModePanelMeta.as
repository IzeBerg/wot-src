package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.SwitchModePanelVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SwitchModePanelMeta extends BaseDAAPIComponent
   {
       
      
      public var switchMode:Function;
      
      public var onSelectCheckBoxAutoSquad:Function;
      
      private var _switchModePanelVO:SwitchModePanelVO;
      
      public function SwitchModePanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._switchModePanelVO)
         {
            this._switchModePanelVO.dispose();
            this._switchModePanelVO = null;
         }
         super.onDispose();
      }
      
      public function switchModeS() : void
      {
         App.utils.asserter.assertNotNull(this.switchMode,"switchMode" + Errors.CANT_NULL);
         this.switchMode();
      }
      
      public function onSelectCheckBoxAutoSquadS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectCheckBoxAutoSquad,"onSelectCheckBoxAutoSquad" + Errors.CANT_NULL);
         this.onSelectCheckBoxAutoSquad(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SwitchModePanelVO = this._switchModePanelVO;
         this._switchModePanelVO = new SwitchModePanelVO(param1);
         this.setData(this._switchModePanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SwitchModePanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
