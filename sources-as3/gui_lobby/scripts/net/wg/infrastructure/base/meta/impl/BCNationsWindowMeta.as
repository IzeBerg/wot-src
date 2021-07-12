package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.nationsWindow.data.NationItemVO;
   import net.wg.gui.tutorial.windows.TutorialDialog;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCNationsWindowMeta extends TutorialDialog
   {
       
      
      public var onNationSelected:Function;
      
      public var onNationShow:Function;
      
      private var _vectorNationItemVO:Vector.<NationItemVO>;
      
      public function BCNationsWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:NationItemVO = null;
         if(this._vectorNationItemVO)
         {
            for each(_loc1_ in this._vectorNationItemVO)
            {
               _loc1_.dispose();
            }
            this._vectorNationItemVO.splice(0,this._vectorNationItemVO.length);
            this._vectorNationItemVO = null;
         }
         super.onDispose();
      }
      
      public function onNationSelectedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onNationSelected,"onNationSelected" + Errors.CANT_NULL);
         this.onNationSelected(param1);
      }
      
      public function onNationShowS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onNationShow,"onNationShow" + Errors.CANT_NULL);
         this.onNationShow(param1);
      }
      
      public final function as_selectNation(param1:uint, param2:Array) : void
      {
         var _loc6_:NationItemVO = null;
         var _loc3_:Vector.<NationItemVO> = this._vectorNationItemVO;
         this._vectorNationItemVO = new Vector.<NationItemVO>(0);
         var _loc4_:uint = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorNationItemVO[_loc5_] = new NationItemVO(param2[_loc5_]);
            _loc5_++;
         }
         this.selectNation(param1,this._vectorNationItemVO);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function selectNation(param1:uint, param2:Vector.<NationItemVO>) : void
      {
         var _loc3_:String = "as_selectNation" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
