package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.tankman.SkillDropForFreeModel;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SkillDropForFreeMeta extends AbstractWindowView
   {
       
      
      public var dropSkills:Function;
      
      private var _skillDropForFreeModel:SkillDropForFreeModel;
      
      public function SkillDropForFreeMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._skillDropForFreeModel)
         {
            this._skillDropForFreeModel.dispose();
            this._skillDropForFreeModel = null;
         }
         super.onDispose();
      }
      
      public function dropSkillsS() : void
      {
         App.utils.asserter.assertNotNull(this.dropSkills,"dropSkills" + Errors.CANT_NULL);
         this.dropSkills();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SkillDropForFreeModel = this._skillDropForFreeModel;
         this._skillDropForFreeModel = new SkillDropForFreeModel(param1);
         this.setData(this._skillDropForFreeModel);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SkillDropForFreeModel) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
