package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.DialogSettingsVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.UseAwardSheetWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class UseAwardSheetWindowMeta extends AbstractWindowView
   {
       
      
      public var accept:Function;
      
      public var cancel:Function;
      
      private var _dialogSettingsVO:DialogSettingsVO;
      
      private var _useAwardSheetWindowVO:UseAwardSheetWindowVO;
      
      public function UseAwardSheetWindowMeta()
      {
