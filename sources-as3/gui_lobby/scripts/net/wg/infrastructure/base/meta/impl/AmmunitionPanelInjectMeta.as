package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.lobby.hangar.ammunitionPanelInject.data.HelpLayoutDataVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AmmunitionPanelInjectMeta extends GFInjectComponent
   {
       
      
      public var onHangarSwitchAnimComplete:Function;
      
      private var _helpLayoutDataVO:HelpLayoutDataVO;
      
      public function AmmunitionPanelInjectMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._helpLayoutDataVO)
         {
            this._helpLayoutDataVO.dispose();
            this._helpLayoutDataVO = null;
         }
         super.onDispose();
      }
      
      public function onHangarSwitchAnimCompleteS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onHangarSwitchAnimComplete,"onHangarSwitchAnimComplete" + Errors.CANT_NULL);
         this.onHangarSwitchAnimComplete(param1);
      }
      
      public final function as_setHelpLayout(param1:Object) : void
      {
         var _loc2_:HelpLayoutDataVO = this._helpLayoutDataVO;
         this._helpLayoutDataVO = new HelpLayoutDataVO(param1);
         this.setHelpLayout(this._helpLayoutDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHelpLayout(param1:HelpLayoutDataVO) : void
      {
         var _loc2_:String = "as_setHelpLayout" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
