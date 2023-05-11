package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.tankman.SkillDropModel;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SkillDropMeta extends AbstractWindowView
   {
       
      
      public var calcDropSkillsParams:Function;
      
      public var dropSkills:Function;
      
      private var _skillDropModel:SkillDropModel;
      
      private var _vectorRetrainButtonVO:Vector.<RetrainButtonVO>;
      
      public function SkillDropMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RetrainButtonVO = null;
         if(this._skillDropModel)
         {
            this._skillDropModel.dispose();
            this._skillDropModel = null;
         }
         if(this._vectorRetrainButtonVO)
         {
            for each(_loc1_ in this._vectorRetrainButtonVO)
            {
               _loc1_.dispose();
            }
            this._vectorRetrainButtonVO.splice(0,this._vectorRetrainButtonVO.length);
            this._vectorRetrainButtonVO = null;
         }
         super.onDispose();
      }
      
      public function calcDropSkillsParamsS(param1:String, param2:Number) : Array
      {
         App.utils.asserter.assertNotNull(this.calcDropSkillsParams,"calcDropSkillsParams" + Errors.CANT_NULL);
         return this.calcDropSkillsParams(param1,param2);
      }
      
      public function dropSkillsS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.dropSkills,"dropSkills" + Errors.CANT_NULL);
         this.dropSkills(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SkillDropModel = this._skillDropModel;
         this._skillDropModel = new SkillDropModel(param1);
         this.setData(this._skillDropModel);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateRetrainButtonsData(param1:Array) : void
      {
         var _loc5_:RetrainButtonVO = null;
         var _loc2_:Vector.<RetrainButtonVO> = this._vectorRetrainButtonVO;
         this._vectorRetrainButtonVO = new Vector.<RetrainButtonVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorRetrainButtonVO[_loc4_] = new RetrainButtonVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updateRetrainButtonsData(this._vectorRetrainButtonVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:SkillDropModel) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateRetrainButtonsData(param1:Vector.<RetrainButtonVO>) : void
      {
         var _loc2_:String = "as_updateRetrainButtonsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
