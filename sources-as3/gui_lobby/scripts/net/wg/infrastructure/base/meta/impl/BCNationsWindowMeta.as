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
      
      public var onHighlightShow:Function;
      
      private var _vectorNationItemVO:Vector.<NationItemVO>;
      
      private var _vectorNationItemVO1:Vector.<NationItemVO>;
      
      public function BCNationsWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:NationItemVO = null;
         var _loc2_:NationItemVO = null;
         if(this._vectorNationItemVO)
         {
            for each(_loc1_ in this._vectorNationItemVO)
            {
               _loc1_.dispose();
            }
            this._vectorNationItemVO.splice(0,this._vectorNationItemVO.length);
            this._vectorNationItemVO = null;
         }
         if(this._vectorNationItemVO1)
         {
            for each(_loc2_ in this._vectorNationItemVO1)
            {
               _loc2_.dispose();
            }
            this._vectorNationItemVO1.splice(0,this._vectorNationItemVO1.length);
            this._vectorNationItemVO1 = null;
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
      
      public function onHighlightShowS() : void
      {
         App.utils.asserter.assertNotNull(this.onHighlightShow,"onHighlightShow" + Errors.CANT_NULL);
         this.onHighlightShow();
      }
      
      public final function as_selectNation(param1:uint, param2:Array, param3:Array) : void
      {
         var _loc10_:NationItemVO = null;
         var _loc11_:NationItemVO = null;
         var _loc4_:Vector.<NationItemVO> = this._vectorNationItemVO;
         this._vectorNationItemVO = new Vector.<NationItemVO>(0);
         var _loc5_:uint = param2.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorNationItemVO[_loc6_] = new NationItemVO(param2[_loc6_]);
            _loc6_++;
         }
         var _loc7_:Vector.<NationItemVO> = this._vectorNationItemVO1;
         this._vectorNationItemVO1 = new Vector.<NationItemVO>(0);
         var _loc8_:uint = param3.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            this._vectorNationItemVO1[_loc9_] = new NationItemVO(param3[_loc9_]);
            _loc9_++;
         }
         this.selectNation(param1,this._vectorNationItemVO,this._vectorNationItemVO1);
         if(_loc4_)
         {
            for each(_loc10_ in _loc4_)
            {
               _loc10_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
         if(_loc7_)
         {
            for each(_loc11_ in _loc7_)
            {
               _loc11_.dispose();
            }
            _loc7_.splice(0,_loc7_.length);
         }
      }
      
      protected function selectNation(param1:uint, param2:Vector.<NationItemVO>, param3:Vector.<NationItemVO>) : void
      {
         var _loc4_:String = "as_selectNation" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
