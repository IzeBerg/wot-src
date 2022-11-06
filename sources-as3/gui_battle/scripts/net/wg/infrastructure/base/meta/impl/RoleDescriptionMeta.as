package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.roleDescription.data.RoleDescriptionVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RoleDescriptionMeta extends BattleDisplayable
   {
       
      
      private var _roleDescriptionVO:RoleDescriptionVO;
      
      public function RoleDescriptionMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._roleDescriptionVO)
         {
            this._roleDescriptionVO.dispose();
            this._roleDescriptionVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RoleDescriptionVO = this._roleDescriptionVO;
         this._roleDescriptionVO = new RoleDescriptionVO(param1);
         this.setData(this._roleDescriptionVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RoleDescriptionVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
