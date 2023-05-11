package net.wg.gui.lobby.profile.pages.formations
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.lobby.profile.pages.formations.data.FormationHeaderVO;
   import net.wg.gui.lobby.profile.pages.formations.data.FormationStatVO;
   import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   
   public class FormationInfoAbstract extends MovieClip implements ISpriteEx
   {
      
      private static const DEFAULT_STAT_WIDTH:int = 73;
       
      
      private var _header:FormationHeader;
      
      private var _statItems:Vector.<LineDescrIconText>;
      
      private var _disposed:Boolean = false;
      
      public function FormationInfoAbstract()
      {
         var _loc1_:LineDescrIconText = null;
         super();
         this._header = this.initHeader();
         this._statItems = this.initStatItems();
         for each(_loc1_ in this._statItems)
         {
            _loc1_.textField.width = DEFAULT_STAT_WIDTH;
         }
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._header.dispose();
         this._header = null;
         if(this._statItems != null)
         {
            this._statItems.splice(0,this._statItems.length);
            this._statItems = null;
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:ProfileFormationsVO = ProfileFormationsVO(param1);
         this.onUpdate(_loc2_);
      }
      
      protected function setHeader(param1:FormationHeaderVO) : void
      {
         this._header.update(param1);
      }
      
      protected function setStats(param1:Array) : void
      {
         var _loc5_:LineDescrIconText = null;
         var _loc6_:Boolean = false;
         var _loc7_:FormationStatVO = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = this._statItems.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._statItems[_loc4_];
            _loc6_ = _loc4_ < _loc2_;
            _loc5_.visible = _loc6_;
            if(_loc6_)
            {
               _loc7_ = param1[_loc4_];
               _loc5_.text = _loc7_.value;
               _loc5_.description = _loc7_.label;
               _loc5_.tooltip = _loc7_.tooltip;
               _loc5_.tooltipParams = _loc7_.tooltipParams;
               _loc5_.iconSource = _loc7_.icon;
            }
            _loc4_++;
         }
      }
      
      protected function onUpdate(param1:ProfileFormationsVO) : void
      {
         throw new AbstractException("FormationInfoAbstract::onUpdate " + Errors.ABSTRACT_INVOKE);
      }
      
      protected function initStatItems() : Vector.<LineDescrIconText>
      {
         throw new AbstractException("FormationInfoAbstract::initStatItems " + Errors.ABSTRACT_INVOKE);
      }
      
      protected function initHeader() : FormationHeader
      {
         throw new AbstractException("FormationInfoAbstract::initHeader " + Errors.ABSTRACT_INVOKE);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
