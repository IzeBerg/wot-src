package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.perksPanel.data.PerkItemVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PerksPanelMeta extends BattleDisplayable
   {
       
      
      private var _vectorPerkItemVO:Vector.<PerkItemVO>;
      
      public function PerksPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PerkItemVO = null;
         if(this._vectorPerkItemVO)
         {
            for each(_loc1_ in this._vectorPerkItemVO)
            {
               _loc1_.dispose();
            }
            this._vectorPerkItemVO.splice(0,this._vectorPerkItemVO.length);
            this._vectorPerkItemVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setPerks(param1:Array) : void
      {
         var _loc5_:PerkItemVO = null;
         var _loc2_:Vector.<PerkItemVO> = this._vectorPerkItemVO;
         this._vectorPerkItemVO = new Vector.<PerkItemVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorPerkItemVO[_loc4_] = new PerkItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setPerks(this._vectorPerkItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setPerks(param1:Vector.<PerkItemVO>) : void
      {
         var _loc2_:String = "as_setPerks" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
